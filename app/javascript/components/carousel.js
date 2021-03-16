import * as Hammer from "hammerjs";

class Carousel {

  constructor(element) {

    this.board = element

    // add first two cards programmatically
    // this.push()
    // this.push()

    // handle gestures
    this.handle()
  }



  handle() {

    // list all cards
    this.cards = this.board.querySelectorAll('.swipe-card')

    // get top card
    this.topCard = this.cards[this.cards.length-1]
    this.topCard.classList.add('active')

    // get next card
    this.nextCard = this.cards[this.cards.length - 2]

     // if at least one card is present
    if (this.cards.length > 0) {

    // set default top card position and scale
    this.topCard.style.transform =
        'translateX(-50%) translateY(-50%) rotate(0deg) rotateY(0deg) scale(1)'

    // destroy previous Hammer instance, if present
    if (this.hammer) this.hammer.destroy()

    // listen for pan gesture on top card
    this.hammer = new Hammer(this.topCard)
    this.hammer.add(new Hammer.Pan({
      position: Hammer.position_ALL,
      threshold: 0
    }))

    // pass event data to custom callback
    this.hammer.on('pan', (e) => {
      this.onPan(e)
    })

    }
  }


  onPan(e) {


    if (!this.isPanning) {

    this.isPanning = true


    // remove transition property
    e.target.style.transition = null
    if (this.nextCard) this.nextCard.style.transition = null

    // get starting coordinates
    let style = window.getComputedStyle(e.target)
    let mx = style.transform.match(/^matrix\((.+)\)$/)
    this.startPosX = mx ? parseFloat(mx[1].split(', ')[4]) : 0
    this.startPosY = mx ? parseFloat(mx[1].split(', ')[5]) : 0

    // get card bounds
    let bounds = e.target.getBoundingClientRect()

    // get finger position, top (1) or bottom (-1) of the card
    this.isDraggingFrom =
      (e.center.y - bounds.top) > e.target.clientHeight / 2 ? -1 : 1
    }


    // get new coordinates
    let posX = e.deltaX + this.startPosX
    let posY = e.deltaY + this.startPosY

    // get ratio between swiped pixels and X axis
    let propX = e.deltaX / document.querySelector('.swipe-box').clientWidth
    let propY = e.deltaY / document.querySelector('.swipe-box').clientHeight

    // get swipe direction, left (-1) or right (1)
    let dirX = e.deltaX < 0 ? -1 : 1

    // get degrees of rotation (between 0 and +/- 45)
    let deg = this.isDraggingFrom * dirX * Math.abs(propX) * 45

    // move and rotate card
    e.target.style.transform =
    'translateX(' + posX + 'px) translateY(' + posY + 'px) rotate(' + deg + 'deg)'



    if (e.isFinal) {

      this.isPanning = false

      let successful = false

      // set back transition property
      e.target.style.transition = 'transform 500ms ease-out'
      if (this.nextCard) this.nextCard.style.transition = 'transform 100ms linear'

      // check threshold
      if (propX > 0.25 && e.direction == Hammer.DIRECTION_RIGHT) {

        successful = true
        // get right border position
        posX = document.querySelector('.swipe-box').clientWidth
        // throw card towards the right border
        e.target.style.transform =
          'translateX(' + posX + 'px) translateY(' + posY + 'px) rotate(' + deg + 'deg)'

      } else if (propX < -0.25 && e.direction == Hammer.DIRECTION_LEFT) {

        successful = true
        // get left border position
        posX = - (document.querySelector('.swipe-box').clientWidth + e.target.clientWidth)
        // throw card towards the left border
        e.target.style.transform =
          'translateX(' + posX + 'px) translateY(' + posY + 'px) rotate(' + deg + 'deg)'

      } else if (propY < -0.25 && e.direction == Hammer.DIRECTION_UP) {

        successful = true
        // get top border position
        posY = - (document.querySelector('.swipe-box').clientHeight + e.target.clientHeight)
        // throw card towards the top border
        e.target.style.transform =
          'translateX(' + posX + 'px) translateY(' + posY + 'px) rotate(' + deg + 'deg)'

      }

       if (successful) {

      // throw card in the chosen direction
      e.target.style.transform =
        'translateX(' + posX + 'px) translateY(' + posY + 'px) rotate(' + deg + 'deg)'

      // wait transition end
      setTimeout(() => {
      // remove swiped card
      document.querySelector('.swipe-box').removeChild(e.target)
      // add new card
      // this.push()
      // handle gestures on new top card
      this.handle()
      }, 200)


      } else {
        // reset card position
        e.target.style.transform =
          'translateX(-50%) translateY(-50%) rotate(0deg)'
        if (this.nextCard) this.nextCard.style.transform =
          'translateX(-50%) translateY(-50%) rotate(0deg) rotateY(0deg) scale(0.95)'
      }
    }
  }

   // push() {
   //  let card = document.createElement('div')
   //  card.classList.add('swipe-card')
   //  card.style.backgroundImage =
   //      "url('https://picsum.photos/320/320/?random=" + Math.round(Math.random() * 1000000) + "')"
   //  this.board.insertBefore(card, this.board.firstChild)
  // }
}



let board = document.querySelector('.swipe-box')

let carousel = new Carousel(board)

export { Carousel };

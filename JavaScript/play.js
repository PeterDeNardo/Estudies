// let name = 'Perepepe'
// let age = 20
// var hasHobbies = true

// //arrow function

// const summarizeUser = (userName, userAge, userHasHobby) => {

//     var menssage = ('Name is ' + userName + ', Age is ' + userAge + ' and the user has hobbies: ' + userHasHobby)

//     return (menssage)
// }

// console.log(summarizeUser(name, age, hasHobbies))

// const person = {
//     name: 'Max',
//     age: 29,
//     greet() {
//         console.log('Hi, I am ' + this.name);
//     }
// };

// ////Destructuring

// const printName = ({ name }) => {
//     console.log(name)
// }

// printName(person)

// const { name, age} = person
// console.log(name, age)

// //Destructurin Arrays

// const hobbies = ['Sports','Cooking'];
// const [hobby1, hobby2] = hobbies
// console.log(hobby1, hobby2)

// person.greet()

// for (let hobby of hobbies){
//     console.log(hobby)
// };

// // o operado "..." permite que eu pegue os elementos do primeiro array e crie uma cópia dentro do meu novo array
// const copiedArray = [...hobbies]

// // da mesma forma posso usar o operado "..." para nao limiter o numero de argumentos d euma funcao

// const toArray = (...args) => {
//     return args;
// }

// // também podemos copiar objetos

// const copiedPerson = { ...person }

// console.log(hobbies.map(hobby => 'Hobby: ' + hobby))
// console.log(hobbies)

//////Async Code

const fetchData = () => {
    const promise = new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('Done!')
        }, 1500)
    })
    return promise
}

setTimeout(() => {
    console.log('Time is done!')
    fetchData()
        .then(text => {
            console.log(text)
            return fetchData()
        })
        .then(text2 => {
            console.log(text2)
        })
}, 2000)
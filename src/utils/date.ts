import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc.js';

dayjs.extend(utc);

/**
 * Formats a date string to a more readable format.
 * @param date - The date string to format.
 * @returns A formatted date string.
 */

// Always use UTC for date operations
export const nowUtc = () => dayjs().utc().toDate();

// This function formats a date to 'YYYY-MM-DD HH:mm:ss' format
export const formatDate = (date: string | Date): string => {
    return dayjs(date).format('YYYY-MM-DD HH:mm:ss');
};

//
export const addUtc = (date: string | Date, amount: number, unit: 'minute' | 'hour' | 'day') => {
    return dayjs(date).utc().add(amount, unit).toDate();
}

// This function checks if a date is before another date
export const isBefore = (date: string | Date, compareDate: string | Date): boolean => {
    return dayjs(date).utc().isBefore(dayjs(compareDate).utc());
}

// This function checks if a date is after another date
export const isAfter = (date: string | Date, compareDate: string | Date): boolean => {
    return dayjs(date).utc().isAfter(dayjs(compareDate).utc());
}
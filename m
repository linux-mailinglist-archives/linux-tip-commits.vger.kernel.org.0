Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBF21516D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  6 Jul 2020 06:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgGFEPh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 6 Jul 2020 00:15:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGFEPh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 6 Jul 2020 00:15:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F9E7AD81;
        Mon,  6 Jul 2020 04:15:36 +0000 (UTC)
Subject: Re: [tip: x86/urgent] x86/entry/32: Fix XEN_PV build dependency
To:     Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
References: <159397824429.4006.6604251447325788449.tip-bot2@tip-bot2>
 <5B8B5845-1145-43BC-B790-B1D1A7B42B28@amacapital.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <88031c06-ebef-8290-fa0b-695859c1a40e@suse.com>
Date:   Mon, 6 Jul 2020 06:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5B8B5845-1145-43BC-B790-B1D1A7B42B28@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 05.07.20 22:24, Andy Lutomirski wrote:
> 
> 
>> On Jul 5, 2020, at 12:44 PM, tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de> wrote:
>>
>> ﻿The following commit has been merged into the x86/urgent branch of tip:
>>
>> Commit-ID:     a4c0e91d1d65bc58f928b80ed824e10e165da22c
>> Gitweb:        https://git.kernel.org/tip/a4c0e91d1d65bc58f928b80ed824e10e165da22c
>> Author:        Ingo Molnar <mingo@kernel.org>
>> AuthorDate:    Sun, 05 Jul 2020 21:33:11 +02:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Sun, 05 Jul 2020 21:39:23 +02:00
>>
>> x86/entry/32: Fix XEN_PV build dependency
>>
>> xenpv_exc_nmi() and xenpv_exc_debug() are only defined on 64-bit kernels,
>> but they snuck into the 32-bit build via <asm/identry.h>, causing the link
>> to fail:
>>
>>   ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_nmi':
>>   (.entry.text+0x817): undefined reference to `xenpv_exc_nmi'
>>
>>   ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_debug':
>>   (.entry.text+0x827): undefined reference to `xenpv_exc_debug'
>>
>> Only use them on 64-bit kernels.
> 
> Jürgen, can you queue a revert for when PV32 goes away?

Yes, will do.


Juergen

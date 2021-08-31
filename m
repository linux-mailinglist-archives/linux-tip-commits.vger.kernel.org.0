Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A13FCB27
	for <lists+linux-tip-commits@lfdr.de>; Tue, 31 Aug 2021 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhHaQD3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 12:03:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232770AbhHaQD2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 12:03:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086E66D;
        Tue, 31 Aug 2021 09:02:33 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4CF3F766;
        Tue, 31 Aug 2021 09:02:31 -0700 (PDT)
Subject: Re: [tip: efi/core] efi: cper: fix scnprintf() use in
 cper_mem_err_location()
To:     Ard Biesheuvel <ardb@kernel.org>, Joe Perches <joe@perches.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        X86 ML <x86@kernel.org>
References: <163014706409.25758.9928933953235257712.tip-bot2@tip-bot2>
 <d18d2c6fd87f552def3210930da34fd276b4fd6d.camel@perches.com>
 <CAMj1kXGhnzwP2OP=ECwNK4sG383wvmybCbvUz5YrqNUHSPgOBQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <44c6c9b3-bade-41ab-2166-b4cd1ed97408@arm.com>
Date:   Tue, 31 Aug 2021 17:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGhnzwP2OP=ECwNK4sG383wvmybCbvUz5YrqNUHSPgOBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi guys,

On 28/08/2021 13:18, Ard Biesheuvel wrote:
> (add RAS/APEI folks)
> 
> On Sat, 28 Aug 2021 at 13:31, Joe Perches <joe@perches.com> wrote:
>>
>> On Sat, 2021-08-28 at 10:37 +0000, tip-bot2 for Rasmus Villemoes wrote:
>>> The following commit has been merged into the efi/core branch of tip:
>> []
>>> efi: cper: fix scnprintf() use in cper_mem_err_location()
>>>
>>> The last two if-clauses fail to update n, so whatever they might have
>>> written at &msg[n] would be cut off by the final nul-termination.
>>>
>>> That nul-termination is redundant; scnprintf(), just like snprintf(),
>>> guarantees a nul-terminated output buffer, provided the buffer size is
>>> positive.
>>>
>>> And there's no need to discount one byte from the initial buffer;
>>> vsnprintf() expects to be given the full buffer size - it's not going
>>> to write the nul-terminator one beyond the given (buffer, size) pair.
>> []
>>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> []
>>> @@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>>>               return 0;
>>>
>>>
>>>       n = 0;
>>> -     len = CPER_REC_LEN - 1;
>>> +     len = CPER_REC_LEN;
>>>       if (mem->validation_bits & CPER_MEM_VALID_NODE)
>>>               n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
>>>       if (mem->validation_bits & CPER_MEM_VALID_CARD)
>>
>> [etc...]
>>
>> Is this always single threaded?
>>
>> It doesn't seem this is safe for reentry as the output buffer
>> being written into is a single static
>>
>> static char rcd_decode_str[CPER_REC_LEN];

> Good question. CPER error record decoding typically occurs in response
> to an error event raised by firmware, so I think this happens to work
> fine in practice. Whether this is guaranteed, I'm not so sure ...

There is locking to prevent concurrent access to the firmware buffer, but that only
serialises the CPER records being copied. The printing may happen in parallel on different
CPUs if there are multiple errors.

cper_estatus_print() is called in NMI context if an NMI indicates a fatal error. See
__ghes_panic().


Thanks,

James

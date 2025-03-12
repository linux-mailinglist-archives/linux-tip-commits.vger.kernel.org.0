Return-Path: <linux-tip-commits+bounces-4126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF23A5D61B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 07:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754E018995DB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B071E3793;
	Wed, 12 Mar 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z66drngJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E641E376C
	for <linux-tip-commits@vger.kernel.org>; Wed, 12 Mar 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760782; cv=none; b=Rj6vO85HK9yri9U0T7klhsvHnvG3Q/x6B0+w6PQoUX5MnVaLL17r9UQAx8qHGykP6kIUE02sUhAmVdbaA15+RKGNjC8fBXeaQy4luYcHHeoWBjb8yK1uagBSeeCQzNKs32+fxrL7Z5Cc+s41t/yKs4zLLTF/SQqliVkRQWtD2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760782; c=relaxed/simple;
	bh=XAuHqWx1gOOHRp1J9YlaoT5/MZs1+FGkDKKALNcr0KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwZzC7Gy7+Io3RVvyOxKmxYBNbyQUP4piI2R5Z8JUhoFJR3hX+DtI3kaN84ia9cmqiGZDAJAtpkkiTJ8wJiYoamEJaag3RvGiI+2dwv5qF0PsEWGhBvKVJM7rk1zjNZNKDwMe2JmKuQFlP36YlP8TUEU+Hbnf5Psu/lGoIpfBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z66drngJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741760779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3MPvvymoydJxq8eOFIuiVyz9J/JXzBvipvYSglAcd2s=;
	b=Z66drngJD6vA0QyuSoSyGl+1u3NT+0Te1yI5Kiy7rMJE7vHCYpWNcQO8wKzthrgIjnGie0
	lHMR62+Qe1YOQDtxunIBTW3kvVMXhvFgqBnYfK56ZvVPpZ/beBluCoLumQC/aSwGaiqzdE
	CBLS7jg+Mz+VxOZ2w9U6tIu+tBUczw8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-DKTZeK-WN8q0EyletSQCVw-1; Wed, 12 Mar 2025 02:26:18 -0400
X-MC-Unique: DKTZeK-WN8q0EyletSQCVw-1
X-Mimecast-MFC-AGG-ID: DKTZeK-WN8q0EyletSQCVw_1741760777
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391425471ddso2335848f8f.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 11 Mar 2025 23:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741760777; x=1742365577;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MPvvymoydJxq8eOFIuiVyz9J/JXzBvipvYSglAcd2s=;
        b=GWfzZc5r44JG7JxUeCrGPy7YPcMiEtGevr3fkzetO4B3zA7i5O6TD8pOWlKHi3rnQE
         eUbXFzzPiWEkALsz7qRS9ViBiMJ26yWb3lW7J+iCP0pM8yOY2ATIoy59wKZYy7NqGLKi
         xxdwICTFvd0vdBlHNUcYSrqINw87BguMuZwZ+7+ppxngoEGorCEkIOR84AYdlJ6ktiyT
         CRuj0JAagqO5Ya0Uana+2rlMx9UtPrDqebCkMpD+g+UeMO6xpbXsijE5WvXnL0p2NEmA
         uNYjOoOPndqM1HainF5J4jp09XYIug6Wl2y710WrLpi1ScaQvfai1B2op3MHRlCeYwQc
         igqg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Mop0fbtKAleUKp29YU16FabfmVkOr/8kirXTFjiVRzIbsl3ozeRmhfCU2wL/iYyiuE4XrSMiKo6MvFxcw4pGzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMqoWH980iGQUVDi3wALclGiq84cFylkGtKcY0XVqcj/2cSR2
	hp9zwGvUFJEe6WEMbluRrLK8w8rFjGG57p7VQu4KIJlBcIclKsFtaUpfXBAUs+Gbg9lC8sTIVa9
	sC8GlDhzDoOw3JNbrHOsUwwJWx8CY4jb4NaOqw1NUug1azgwMD7Svk8B7izdqfKe0LYfP
X-Gm-Gg: ASbGncvlQ7RYNPo/qSzgFDsvrJo7Okx4/AB6OJvgPk0EVzOODiTu3UHTd04+46pCeJ5
	r0wO7QYKMr0VDkEOE7LmV9JbAXKMvgwOyf4ohznT92Q20Xw4+rS7hNXcI/L23TlZI2XA3RIQB2m
	UT6ekZPfvl28MLZLCfpJcrvBIyw10alQjR/6ax5nJQrWV07zy4I5x9V/NmyvmZqvY88krDF3B7L
	qY3rreEuolxWPlPJdCV6gBV756CcPsWusyG06j2o6ePlRhPHwMcEJM5ryWudPLObjIHdBClNmHt
	cxntIebA4Ozf0yPbB4n9CmNAhIo0DRTAp9KSe25pPTNGAY8=
X-Received: by 2002:a05:6000:1fa9:b0:391:212:459a with SMTP id ffacd0b85a97d-39132d3b46fmr21027195f8f.22.1741760776863;
        Tue, 11 Mar 2025 23:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEROZqSN5zDS+civ2KWmAspimySRPzHTyvyXd1X+03LS+BLwpUgEfqjt4DU02kMZNSvWwSdOg==
X-Received: by 2002:a05:6000:1fa9:b0:391:212:459a with SMTP id ffacd0b85a97d-39132d3b46fmr21027176f8f.22.1741760776439;
        Tue, 11 Mar 2025 23:26:16 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de. [109.42.51.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm19745119f8f.88.2025.03.11.23.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 23:26:15 -0700 (PDT)
Message-ID: <0fd91233-0286-43fc-985f-8aab2d4f299c@redhat.com>
Date: Wed, 12 Mar 2025 07:26:13 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/headers] x86/headers: Replace __ASSEMBLY__ with
 __ASSEMBLER__ in UAPI headers
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 tip-bot2 for Thomas Huth <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20250310104256.123527-1-thuth@redhat.com>
 <174160617464.14745.3081665054786018758.tip-bot2@tip-bot2>
 <B004CC50-5077-44A2-9EC9-6444BBA400A8@zytor.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <B004CC50-5077-44A2-9EC9-6444BBA400A8@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2025 02.15, H. Peter Anvin wrote:
> On March 10, 2025 4:29:34 AM PDT, tip-bot2 for Thomas Huth <tip-bot2@linutronix.de> wrote:
>> The following commit has been merged into the x86/headers branch of tip:
>>
>> Commit-ID:     e28eecf2602bdce826833ccb9a6b7a6bacafd98b
>> Gitweb:        https://git.kernel.org/tip/e28eecf2602bdce826833ccb9a6b7a6bacafd98b
>> Author:        Thomas Huth <thuth@redhat.com>
>> AuthorDate:    Mon, 10 Mar 2025 11:42:56 +01:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Mon, 10 Mar 2025 12:18:42 +01:00
>>
>> x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in UAPI headers
>>
>> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
>> this is not really useful for UAPI headers (unless the userspace
>> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
>> gets set automatically by the compiler when compiling assembly
>> code.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Brian Gerst <brgerst@gmail.com>
>> Link: https://lore.kernel.org/r/20250310104256.123527-1-thuth@redhat.com
>> ---
>> arch/x86/include/uapi/asm/bootparam.h  | 4 ++--
>> arch/x86/include/uapi/asm/e820.h       | 4 ++--
>> arch/x86/include/uapi/asm/ldt.h        | 4 ++--
>> arch/x86/include/uapi/asm/msr.h        | 4 ++--
>> arch/x86/include/uapi/asm/ptrace-abi.h | 6 +++---
>> arch/x86/include/uapi/asm/ptrace.h     | 4 ++--
>> arch/x86/include/uapi/asm/setup_data.h | 4 ++--
>> arch/x86/include/uapi/asm/signal.h     | 8 ++++----
>> 8 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
>> index 9b82eeb..dafbf58 100644
>> --- a/arch/x86/include/uapi/asm/bootparam.h
>> +++ b/arch/x86/include/uapi/asm/bootparam.h
>> @@ -26,7 +26,7 @@
>> #define XLF_5LEVEL_ENABLED		(1<<6)
>> #define XLF_MEM_ENCRYPTION		(1<<7)
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>
>> #include <linux/types.h>
>> #include <linux/screen_info.h>
>> @@ -210,6 +210,6 @@ enum x86_hardware_subarch {
>> 	X86_NR_SUBARCHS,
>> };
>>
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>
>> #endif /* _ASM_X86_BOOTPARAM_H */
>> diff --git a/arch/x86/include/uapi/asm/e820.h b/arch/x86/include/uapi/asm/e820.h
>> index 2f491ef..55bc668 100644
>> --- a/arch/x86/include/uapi/asm/e820.h
>> +++ b/arch/x86/include/uapi/asm/e820.h
>> @@ -54,7 +54,7 @@
>>   */
>> #define E820_RESERVED_KERN        128
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>> #include <linux/types.h>
>> struct e820entry {
>> 	__u64 addr;	/* start of memory segment */
>> @@ -76,7 +76,7 @@ struct e820map {
>> #define BIOS_ROM_BASE		0xffe00000
>> #define BIOS_ROM_END		0xffffffff
>>
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>
>>
>> #endif /* _UAPI_ASM_X86_E820_H */
>> diff --git a/arch/x86/include/uapi/asm/ldt.h b/arch/x86/include/uapi/asm/ldt.h
>> index d62ac5d..a82c039 100644
>> --- a/arch/x86/include/uapi/asm/ldt.h
>> +++ b/arch/x86/include/uapi/asm/ldt.h
>> @@ -12,7 +12,7 @@
>> /* The size of each LDT entry. */
>> #define LDT_ENTRY_SIZE	8
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>> /*
>>   * Note on 64bit base and limit is ignored and you cannot set DS/ES/CS
>>   * not to the default values if you still want to do syscalls. This
>> @@ -44,5 +44,5 @@ struct user_desc {
>> #define MODIFY_LDT_CONTENTS_STACK	1
>> #define MODIFY_LDT_CONTENTS_CODE	2
>>
>> -#endif /* !__ASSEMBLY__ */
>> +#endif /* !__ASSEMBLER__ */
>> #endif /* _ASM_X86_LDT_H */
>> diff --git a/arch/x86/include/uapi/asm/msr.h b/arch/x86/include/uapi/asm/msr.h
>> index e7516b4..4b8917c 100644
>> --- a/arch/x86/include/uapi/asm/msr.h
>> +++ b/arch/x86/include/uapi/asm/msr.h
>> @@ -2,7 +2,7 @@
>> #ifndef _UAPI_ASM_X86_MSR_H
>> #define _UAPI_ASM_X86_MSR_H
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>
>> #include <linux/types.h>
>> #include <linux/ioctl.h>
>> @@ -10,5 +10,5 @@
>> #define X86_IOC_RDMSR_REGS	_IOWR('c', 0xA0, __u32[8])
>> #define X86_IOC_WRMSR_REGS	_IOWR('c', 0xA1, __u32[8])
>>
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>> #endif /* _UAPI_ASM_X86_MSR_H */
>> diff --git a/arch/x86/include/uapi/asm/ptrace-abi.h b/arch/x86/include/uapi/asm/ptrace-abi.h
>> index 16074b9..5823584 100644
>> --- a/arch/x86/include/uapi/asm/ptrace-abi.h
>> +++ b/arch/x86/include/uapi/asm/ptrace-abi.h
>> @@ -25,7 +25,7 @@
>>
>> #else /* __i386__ */
>>
>> -#if defined(__ASSEMBLY__) || defined(__FRAME_OFFSETS)
>> +#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
>> /*
>>   * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
>>   * unless syscall needs a complete, fully filled "struct pt_regs".
>> @@ -57,7 +57,7 @@
>> #define EFLAGS 144
>> #define RSP 152
>> #define SS 160
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>
>> /* top of stack page */
>> #define FRAME_SIZE 168
>> @@ -87,7 +87,7 @@
>>
>> #define PTRACE_SINGLEBLOCK	33	/* resume execution until next branch */
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>> #include <linux/types.h>
>> #endif
>>
>> diff --git a/arch/x86/include/uapi/asm/ptrace.h b/arch/x86/include/uapi/asm/ptrace.h
>> index 85165c0..e0b5b4f 100644
>> --- a/arch/x86/include/uapi/asm/ptrace.h
>> +++ b/arch/x86/include/uapi/asm/ptrace.h
>> @@ -7,7 +7,7 @@
>> #include <asm/processor-flags.h>
>>
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>
>> #ifdef __i386__
>> /* this struct defines the way the registers are stored on the
>> @@ -81,6 +81,6 @@ struct pt_regs {
>>
>>
>>
>> -#endif /* !__ASSEMBLY__ */
>> +#endif /* !__ASSEMBLER__ */
>>
>> #endif /* _UAPI_ASM_X86_PTRACE_H */
>> diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
>> index b111b0c..50c45ea 100644
>> --- a/arch/x86/include/uapi/asm/setup_data.h
>> +++ b/arch/x86/include/uapi/asm/setup_data.h
>> @@ -18,7 +18,7 @@
>> #define SETUP_INDIRECT			(1<<31)
>> #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>
>> #include <linux/types.h>
>>
>> @@ -78,6 +78,6 @@ struct ima_setup_data {
>> 	__u64 size;
>> } __attribute__((packed));
>>
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>
>> #endif /* _UAPI_ASM_X86_SETUP_DATA_H */
>> diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
>> index f777346..1067efa 100644
>> --- a/arch/x86/include/uapi/asm/signal.h
>> +++ b/arch/x86/include/uapi/asm/signal.h
>> @@ -2,7 +2,7 @@
>> #ifndef _UAPI_ASM_X86_SIGNAL_H
>> #define _UAPI_ASM_X86_SIGNAL_H
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>> #include <linux/types.h>
>> #include <linux/compiler.h>
>>
>> @@ -16,7 +16,7 @@ struct siginfo;
>> typedef unsigned long sigset_t;
>>
>> #endif /* __KERNEL__ */
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>
>>
>> #define SIGHUP		 1
>> @@ -68,7 +68,7 @@ typedef unsigned long sigset_t;
>>
>> #include <asm-generic/signal-defs.h>
>>
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>
>>
>> # ifndef __KERNEL__
>> @@ -106,6 +106,6 @@ typedef struct sigaltstack {
>> 	__kernel_size_t ss_size;
>> } stack_t;
>>
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>
>> #endif /* _UAPI_ASM_X86_SIGNAL_H */
> 
> Wouldn't it be better to replace this everywhere for consistency?

Yes, also suggested by Arnd here:

https://lore.kernel.org/linux-s390/1be19a7f-f43c-4025-8cf9-5f831c4125f5@app.fastmail.com/

I'll try to come up with a patch series in the next days. I think I'll keep 
separate patches for the different architectures and uapi vs. non-uapi, so 
that it is easier to review and split again in case it is necessary, so it 
should be ok to keep this patch here - or if you prefer, drop it again from 
your queue for now, as it is better for you.

  Thomas




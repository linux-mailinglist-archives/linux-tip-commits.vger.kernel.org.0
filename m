Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35D29D606
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgJ1WLB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgJ1WK7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:59 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0729C0613D1
        for <linux-tip-commits@vger.kernel.org>; Wed, 28 Oct 2020 15:10:58 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f6so517277ybr.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 28 Oct 2020 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpvqDFTkgoj21BdY1pTBOrwAo1cSX7C2DrwyEeBthb0=;
        b=hmu6Uyd1Gc7QqAmRGDaehKNzIEHFFVZG/PPYkq4ZaUmooqpshdaE0gVQJL47IyDUs0
         aa2GXsroHFjXApjXlR2NG81QyRF6TWy8OJ5Ruho6lV2jn0OOiJwvcsnUyKGGbE4Qun6p
         yLV+PoWlWh/lpdxMCeKORAUXgoGP5QKakKGhvfB0kHShumuv9SKYcLJLacUFkVePZY/I
         kZGqUs4Bky+kPkKzU8jeJpqdHvRisSNEuDmsTftWGirndVwGm3n8ES2p2NUNTlrAiH7k
         N/gb0RjAJy5/x+EklKbygR1hyS3FlR8Tmu9bNer1/vqXlrkKvwQEXxwz9qaCfprZswEk
         3YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpvqDFTkgoj21BdY1pTBOrwAo1cSX7C2DrwyEeBthb0=;
        b=rSMyWn/xNDUyt408XQ9J6x6obQJZcbRbCv4c5slhW4BARX8Vare1n7XLTWBE8m+W0/
         2hAGr9FwVpWBA4u5M/z6cT8aMqB06GdjyXpF8WjCdNbKzTHobDA3p91VB/Tt6vo3Bnty
         88bHhR32hrNQGg/fBQX+NAgOtGe1u90j9TFJFr/cbIwjZ3o47/XfqigF7Tv1dKzTOnJy
         X7eMkKbPLIAGMCmXLCHH4k6fpzdrZBGMc0g92QBXTticD0bVotOH8Mj6wwCXtI9ZBqGJ
         Q4l0jGHuxjI634eVnpXtUW1eA5x5HjKMUnoGUJnsZBnv+5J3HONSyeVkf4gy4e0hukNk
         Ii9Q==
X-Gm-Message-State: AOAM533fXtAZWkqnMwl0b4a1vr3do56jzdm70+zkqjqBLqSDVXa8OQeM
        L9ec5zBvVTMAOT0nTIdYZKMyKkdD4jquUQQjlJG7Bqos83/PE6Sq
X-Google-Smtp-Source: ABdhPJwg81J95bq/E6nPimq6xCcVhmcL1hYDUWbH2VVxCaOeVS3rOgpWN0zdv6OGnLhkSCFQJPP7LbhuFVKXhlqIBBM=
X-Received: by 2002:a25:d906:: with SMTP id q6mr531935ybg.316.1603908196352;
 Wed, 28 Oct 2020 11:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200907131613.12703-64-joro@8bytes.org> <159972972598.20229.12880317872521101289.tip-bot2@tip-bot2>
 <CAAYXXYx=Eq4gYfUqdO7u37VRD_GpPYFQgN=GZySmAMcDc2AM=g@mail.gmail.com>
 <CAAYXXYw7ZKM+4ZCzn_apb4iy07R5VfcYeyus-kc0ETh_vkBkPg@mail.gmail.com> <20201028094952.GI22179@suse.de>
In-Reply-To: <20201028094952.GI22179@suse.de>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Wed, 28 Oct 2020 11:03:05 -0700
Message-ID: <CAAYXXYwqYeXY3gaExMYX9Pt0nN_D=jbz9FWSuk1hDF8GcK-kfA@mail.gmail.com>
Subject: Re: [tip: x86/seves] x86/kvm: Add KVM-specific VMMCALL handling under SEV-ES
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

I might be missing something here but I think what you say is only
correct for the kvm_hypercall4 cases. All other functions use a
smaller number of registers. #VC blindly assumes that all those
registers are used in the vmcall and exposes them. Here are some
examples:

For example in the kvm_hypercall2 only rax, rbx, and rcx should be
exposed. apic_id address is leaked with rdx when this hypercall is
used in kvm_kick_cpu function. RSI is never used. I am not sure what
value will be exposed to VMM in this case:

 54 static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 55                                   unsigned long p2)
 56 {
 57         long ret;
 58         asm volatile(KVM_HYPERCALL
 59                      : "=a"(ret)
 60                      : "a"(nr), "b"(p1), "c"(p2)
 61                      : "memory");
 62         return ret;
 63 }
And this function is called in :

820 static void kvm_kick_cpu(int cpu)
821 {
822         int apicid;
823         unsigned long flags = 0;
824
825         apicid = per_cpu(x86_cpu_to_apicid, cpu);
826         kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
827 }

looking to what it is compiled in my machine :

151215 ffffffff8105def0 <kvm_kick_cpu>:
 151216 {
 151217 ffffffff8105def0:       e8 fb 9e ff ff          callq
ffffffff81057df0 <__fentry__>
 151218         apicid = per_cpu(x86_cpu_to_apicid, cpu);
 151219 ffffffff8105def5:       48 63 ff                movslq %edi,%rdi
 151220 {
 151221 ffffffff8105def8:       53                      push   %rbx
 151222         apicid = per_cpu(x86_cpu_to_apicid, cpu);
 151223 ffffffff8105def9:       48 c7 c0 58 16 01 00    mov    $0x11658,%rax
 151224
 151225 static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 151226                                   unsigned long p2)
 151227 {
 151228         long ret;
 151229         asm volatile(KVM_HYPERCALL
 151230 ffffffff8105df00:       31 db                   xor    %ebx,%ebx
 151231 ffffffff8105df02:       48 8b 14 fd 00 19 cb    mov
-0x7e34e700(,%rdi,8),%rdx
 151232 ffffffff8105df09:       81
 151233         kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
 151234 ffffffff8105df0a:       0f b7 0c 02             movzwl
(%rdx,%rax,1),%ecx
 151235 ffffffff8105df0e:       b8 05 00 00 00          mov    $0x5,%eax
 151236 ffffffff8105df13:       0f 01 c1                vmcall
 151237 }
 151238 ffffffff8105df16:       5b                      pop    %rbx
 151239 ffffffff8105df17:       c3                      retq


Similarly kvm_hypercall1 only need 2 registers to expose:

 44 static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 45 {
 46         long ret;
 47         asm volatile(KVM_HYPERCALL
 48                      : "=a"(ret)
 49                      : "a"(nr), "b"(p1)
 50                      : "memory");
 51         return ret;
 52 }

And an example where it is used:

562 static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
563 {
564         int cpu;
565
566         native_send_call_func_ipi(mask);
567
568         /* Make sure other vCPUs get a chance to run if they need to. */
569         for_each_cpu(cpu, mask) {
570                 if (vcpu_is_preempted(cpu)) {
571                         kvm_hypercall1(KVM_HC_SCHED_YIELD,
per_cpu(x86_cpu_to_apicid, cpu));
572                         break;
573                 }
574         }
575 }

If we look at the function decompiled in my platform, here
x86_cpu_to_apicid address is leaked in rdx. RSI also leaks some
information from kvm_smp_send_call_function_ipi function. RCX is not
used so it might include something from a higher caller.

 151243 ffffffff8105df20 <kvm_smp_send_call_func_ipi>:
 151244 {
 151245 ffffffff8105df20:       e8 cb 9e ff ff          callq
ffffffff81057df0 <__fentry__>
 151246 ffffffff8105df25:       53                      push   %rbx
 151247 ffffffff8105df26:       48 89 fb                mov    %rdi,%rbx
 151248         native_send_call_func_ipi(mask);
 151249 ffffffff8105df29:       e8 a2 45 ff ff          callq
ffffffff810524d0 <native_send_call_func_ipi>
 151250         for_each_cpu(cpu, mask) {
 151251 ffffffff8105df2e:       41 b8 ff ff ff ff       mov    $0xffffffff,%r8d
 151252 ffffffff8105df34:       eb 0e                   jmp
ffffffff8105df44 <kvm_smp_send_call_func_ipi+0x24>
 151253         return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
 151254 ffffffff8105df36:       49 63 f8                movslq %r8d,%rdi
 151255 ffffffff8105df39:       ff 14 25 90 93 02 82    callq
*0xffffffff82029390
 151256                 if (vcpu_is_preempted(cpu)) {
 151257 ffffffff8105df40:       84 c0                   test   %al,%al
 151258 ffffffff8105df42:       75 18                   jne
ffffffff8105df5c <kvm_smp_send_call_func_ipi+0x3c>
 151259         for_each_cpu(cpu, mask) {
 151260 ffffffff8105df44:       44 89 c7                mov    %r8d,%edi
 151261 ffffffff8105df47:       48 89 de                mov    %rbx,%rsi
 151262 ffffffff8105df4a:       e8 61 44 39 00          callq
ffffffff813f23b0 <cpumask_next>
 151263 ffffffff8105df4f:       3b 05 2f 7e 12 01       cmp
0x1127e2f(%rip),%eax        # ffffffff82185d84 <nr_cpu_ids>
 151264 ffffffff8105df55:       41 89 c0                mov    %eax,%r8d
 151265 ffffffff8105df58:       72 dc                   jb
ffffffff8105df36 <kvm_smp_send_call_func_ipi+0x16>
 151266 }
 151267 ffffffff8105df5a:       5b                      pop    %rbx
 151268 ffffffff8105df5b:       c3                      retq
 151269                         kvm_hypercall1(KVM_HC_SCHED_YIELD,
per_cpu(x86_cpu_to_apicid, cpu));
 151270 ffffffff8105df5c:       48 8b 14 fd 00 19 cb    mov
-0x7e34e700(,%rdi,8),%rdx
 151271 ffffffff8105df63:       81
 151272 ffffffff8105df64:       48 c7 c0 58 16 01 00    mov    $0x11658,%rax
 151273 ffffffff8105df6b:       0f b7 1c 02             movzwl
(%rdx,%rax,1),%ebx
 151274         asm volatile(KVM_HYPERCALL
 151275 ffffffff8105df6f:       b8 0b 00 00 00          mov    $0xb,%eax
 151276 ffffffff8105df74:       0f 01 c1                vmcall
 151277 }

I am not sure how those leaked registers can be used, but depending on
which function call hypercall[0-3], there will be some leak.

-Erdem



On Wed, Oct 28, 2020 at 2:49 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Tue, Oct 27, 2020 at 04:14:15PM -0700, Erdem Aktas wrote:
> > It seems to me that the kvm_sev_es_hcall_prepare is leaking more
> > information than it is needed. Is this an expected behavior?
>
> What exactly is leaked? The kvm hypercall uses RAX, RBX, RCX, RDX and
> RSI for parameters.
>
> Regards,
>
>         Joerg

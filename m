Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39C28A890
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgJKRui (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgJKRui (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:50:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA1C0613CE;
        Sun, 11 Oct 2020 10:50:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602438635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63yLWK2+BRU4pgQg7P1iQBQ6HnS8E8ex6hZ8x10V7+Y=;
        b=4Ts/RQCOWLizbXiWkzqvt88oX6xA3QiTdMXUTz8a4zVRtu7PvL4+3NJT+r7PmNAhjss/lu
        7LUQ7qku+5qaRp+ot632pIOSzxK9AgW/++TCbxTa71dBH1y9sxC2IhSkd0Q1c5sp2Xon7X
        /uiu+XoXNXF2OT9S6y5NAN3tv8YK3avqykzQenYQmrONql6ejGtNpshDD0Qv1oGxrCYRfg
        eBdIE1a2Xx4WSwybr9VeFWnL8ig/tYuIGHpPIa/0RT4btNlA575jVQ4svf6AMifos0tzdh
        kYL+oAZciKKhABFW4vktcgSXDRXEr2EnV9Co3hjiUKHqzmx/u1boRKh5hC/PGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602438635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63yLWK2+BRU4pgQg7P1iQBQ6HnS8E8ex6hZ8x10V7+Y=;
        b=Y11pf0L7+uekGHYtGHfkreQ1H7i9EOJ0a9ZGIs2z3QsJjguxqS+FLoecQWIFUsnobGU+KZ
        qnUf7IeYbXBnVwAQ==
To:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Convert Divide Error to IDTENTRY
In-Reply-To: <CACT4Y+bTZFkuZd7+bPArowOv-7Die+WZpfOWnEO_Wgs3U59+oA@mail.gmail.com>
References: <20200505134904.663914713@linutronix.de> <158991831479.17951.17390452716048622271.tip-bot2@tip-bot2> <CACT4Y+bTZFkuZd7+bPArowOv-7Die+WZpfOWnEO_Wgs3U59+oA@mail.gmail.com>
Date:   Sun, 11 Oct 2020 19:50:35 +0200
Message-ID: <87mu0sr6s4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Oct 11 2020 at 17:25, Dmitry Vyukov wrote:
> On Tue, May 19, 2020 at 9:59 PM tip-bot2 for Thomas Gleixner
> <tip-bot2@linutronix.de> wrote:
>> The following commit has been merged into the x86/entry branch of tip:
>>
>> -DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
>>
>> +DEFINE_IDTENTRY(exc_divide_error)
>> +{
>> +       do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
>> +                     FPE_INTDIV, error_get_trap_addr(regs));
>> +}
>
> I suppose this is a copy-paste typo and was supposed to be "divide
> error", right?

Yeah. That was definitely unintentional.

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBED7100AE0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Nov 2019 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKRRwu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Nov 2019 12:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfKRRwu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Nov 2019 12:52:50 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779222195D;
        Mon, 18 Nov 2019 17:52:48 +0000 (UTC)
Date:   Mon, 18 Nov 2019 12:52:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ftrace: Mark ftrace_modify_code_direct() __ref
Message-ID: <20191118125246.3eb768fa@oasis.local.home>
In-Reply-To: <20191118173510.GK6363@zn.tnic>
References: <20191111132457.761255803@infradead.org>
        <157381099055.29467.10982011694493970062.tip-bot2@tip-bot2>
        <20191116204607.GC23231@zn.tnic>
        <20191118173510.GK6363@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, 18 Nov 2019 18:35:10 +0100
Borislav Petkov <bp@alien8.de> wrote:


> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 2a179fb35cd1..108ee96f8b66 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -99,7 +99,12 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
>  	return 0;
>  }
>  
> -static int
> +/*
> + * Marked __ref because it calls text_poke_early() which is .init.text. That is
> + * ok because that call will happen early, during boot, when .init sections are
> + * still present.
> + */
> +static int __ref

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  ftrace_modify_code_direct(unsigned long ip, const char *old_code,
>  			  const char *new_code)
>  {


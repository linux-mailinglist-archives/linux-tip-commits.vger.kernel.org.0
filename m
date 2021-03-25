Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF652349568
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 16:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCYP1n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 11:27:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCYP1L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 11:27:11 -0400
Date:   Thu, 25 Mar 2021 15:27:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616686030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uNyyO5Dvy6H8/hzst5NroS4qKxoUbvoh8rzDQUQ3KfM=;
        b=MPX6Cx4DKONcKSYSwqpYz386rMTHgx9xrrkhVbzoEs9sWGEMmGEirF5aYo7ESj4iX5Ny/J
        m/BiyytDnT3l3STMrBK9lFyru2r8MDPJuJxYvgMH8rE3/Ve1uWTu3ZA2eCzJJCVElFkO0O
        KsYlVFkoF/sMAQADZ80UZDX66Ep1eR4m4nDeEeH0Y/KZyUepXABHUE9ddaEoETdyj6o0EX
        oeDIziNGiZD7oAx5qp4gOTFQDeobkqpeJ8mjxylz3Q7HY4tHqYKATTi0at/ntuPsgI9loX
        uuqAHplP7YgMYGfc2pywsx3RpXJA/qxqR/0dEQGi9Mf3jDQHjyANQNM5F8O7kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616686030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uNyyO5Dvy6H8/hzst5NroS4qKxoUbvoh8rzDQUQ3KfM=;
        b=abH59x5vSVhISgKE0eOi2+Q5T2MkrOYM8mE3avmssWiVcxm49QTorAJbssMsSIJBB0zRyc
        dhKHGgAEsrqASyAg==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/syscalls: Fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, mic@linux.microsoft.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210301131533.64671-2-masahiroy@kernel.org>
References: <20210301131533.64671-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <161668602985.398.1651880509532185393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7dfe553affd0d003c7535b7ba60d09193471ea9d
Gitweb:        https://git.kernel.org/tip/7dfe553affd0d003c7535b7ba60d0919347=
1ea9d
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 01 Mar 2021 22:15:26 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 16:20:41 +01:00

x86/syscalls: Fix -Wmissing-prototypes warnings from COND_SYSCALL()

Building kernel/sys_ni.c with W=3D1 emits tons of -Wmissing-prototypes warnin=
gs:

  $ make W=3D1 kernel/sys_ni.o
    [ snip ]
    CC      kernel/sys_ni.o
     ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous pro=
totype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
     ...

The problem is in __COND_SYSCALL(), the __SYS_STUB0() and __SYS_STUBx() macros
defined a few lines above already have forward declarations.

Let's do likewise for __COND_SYSCALL() to fix the warnings.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210301131533.64671-2-masahiroy@kernel.org
---
 arch/x86/include/asm/syscall_wrapper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/sy=
scall_wrapper.h
index a84333a..80c08c7 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *reg=
s);
 	}
=20
 #define __COND_SYSCALL(abi, name)					\
+	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
 	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
 	{								\
 		return sys_ni_syscall();				\

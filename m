Return-Path: <linux-tip-commits+bounces-6646-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34CB59567
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F87F1BC1D7E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21160306B37;
	Tue, 16 Sep 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSkiynBU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VS1gJU9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F492C327C;
	Tue, 16 Sep 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022681; cv=none; b=fnYBKz6yh/5n1DG8tg2A+ol8nwngbVKnsxpflfU5sEijzt771ocfZJFGhVn5b9wE6FFflLmpwQN05uyJ8cdsohLzAG32J1uwai2SmoVx/jJEebtRKYILf9FGDHGzhLxrg0U9R4tGwRwjdMeTi2PZKF/p4ZhaxBqV2SyR6Vf47uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022681; c=relaxed/simple;
	bh=dvRhAkpMJ0JXxyp2dTA1oVawQhcgsR2lg+67t96DEs0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mfOTr6OQV9nmZOmPPlUcOCD5M/hq6cP9aweORgR5acGBSbSas/VZbsw8HLZ9jfpkYYA3CYwnYlj2iIamyuBadcVwedLXJBEpVBgJszFRwY4IGZFELqx7KDAASknHJc0jEka+pR8BSGs3SaKWyPI3WoGJrDNxgTz3NDbVlFYAj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSkiynBU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VS1gJU9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 11:37:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758022677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTQ25WItaxQbHS0kre9UgIY7u1QCyVudS0qPYHbHvT4=;
	b=pSkiynBUJ2cZWrdcgYlw+jWt4xeWdJ8Mi9LrOqQAU9ZSS/N6d6ehrkZeUgwvVZD5gxd8ze
	tIFYnW4E1V8HuPznzsUFsFVPiCXA1WH7aLXkD3O71CRIjqVMdBSvpgGxKlbJPPu/dNuDXL
	2+Y+R72iivvGbBsGTbGCwXoCxs/cC1igKKJTgnmqbEVGwzoEtULASvw9FcMRmnLJ7qlTrw
	ofzyeUSoy5EYVMjvmEJ8QksqhWU3EGwXZyicV688ycZaK40YDX0wRxGvojSUbkNn7GRI5Y
	ie+1CByDtLCFhg1AgsTGP61Vd79n/c3KRHlN+Q3uzTpO9ygnxAQRc9gw8bOLBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758022677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTQ25WItaxQbHS0kre9UgIY7u1QCyVudS0qPYHbHvT4=;
	b=VS1gJU9HYKr20NmOChDKjabrukHGrvVqR7ongrqvURVrybWRu9bprxJXZcPiuPn4AlPe0c
	2RKRbb46QjZCGXCw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Return error from uprobe syscall when
 not called from trampoline
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905205731.1961288-2-jolsa@kernel.org>
References: <20250905205731.1961288-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802267623.709179.17067619758138667836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d3aeb6d97b22272bb4783c6d4309d81bb0a4527c
Gitweb:        https://git.kernel.org/tip/d3aeb6d97b22272bb4783c6d4309d81bb0a=
4527c
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 05 Sep 2025 22:57:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 13:46:29 +02:00

uprobes/x86: Return error from uprobe syscall when not called from trampoline

Currently uprobe syscall handles all errors with forcing SIGILL to current
process. As suggested by Andrii it'd be helpful for uprobe syscall detection
to return error value for the !in_uprobe_trampoline check.

This way we could just call uprobe syscall and based on return value we will
find out if the kernel has it.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4..845aeaf 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -810,7 +810,7 @@ SYSCALL_DEFINE0(uprobe)
=20
 	/* Allow execution only from uprobe trampolines. */
 	if (!in_uprobe_trampoline(regs->ip))
-		goto sigill;
+		return -ENXIO;
=20
 	err =3D copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
 	if (err)


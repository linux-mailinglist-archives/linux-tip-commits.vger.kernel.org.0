Return-Path: <linux-tip-commits+bounces-8071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F01D39750
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 16:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004813005B99
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03321E1A33;
	Sun, 18 Jan 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qGiA3mVA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1kM3xKX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432331FC7;
	Sun, 18 Jan 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748447; cv=none; b=Wg9sAADU9O6y6cCl21Yn4UpMqRa9MyxDreXcyLMJmTQj2z7wSBL8App4tk4+jhu5saHjCM6gXW7LaG1QZsORC5Z1D8EqULQCv5ILi0pMAzTPR1rRzswqgzJg/Y9Met/2/IN+iTgXJIROGT8e2kZxJQS4RcPNwII7+WJFeJnliwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748447; c=relaxed/simple;
	bh=+Utbp+lBRPgeKV43UaFFHdVa73RqR+cVzQ+u+dz1jXE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F1ZnizXZj6DnOgLHgcbkP/UC4y3GJLvrQY4KyCrDIG9tnZgP0pymlOJHxGGF6ylzjpcLEwU5gYVYcrLGFKICntZq+iEFgctl4Wisl83eeCJSzlQ+1j8aWzO1M/zcaNoT3S8/WwC17dcG9MB+lOoSj0FcbfOBicSooNi2GnSyOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qGiA3mVA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1kM3xKX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 15:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768748444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoADQlREfjRFtIt6Y5Y3nvWe/oT+R2/Oden9dhCHevg=;
	b=qGiA3mVAuj5QbTJW6F7sZzx5gOdp70O94aVmTRLrZyZsOFsxRoKxzAOPOWmBwDIzDQyXx5
	8Q1CNEU+yZ0i4SDWt0qxkuZUzzFjZ1EjJMkGkeL7SJFgKhHFfL5k5lGWh6fFrYE2s5CaVN
	LbI59hTLxim2aB2ULUcyhhlJkJzz+UWc7AOZeI3PWcURkGeAGImbLlfkJ8yXwP34rQQlPh
	knJ+uhqBeodTYJ84GGfq0CodrGvm48KhKJ3FyPAPcZG3gNDxoMTdjunPBBqt0SZ4Y3P/U1
	ABtdpHTfJJCia8KpBu8GhdXo9jEkt97DCdFDKmqZfPkB3GIGEKtz7hT4m1d8SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768748444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoADQlREfjRFtIt6Y5Y3nvWe/oT+R2/Oden9dhCHevg=;
	b=H1kM3xKXLUddYxBwkO5geABz/6zOVQF8vvynf2EG8YajH6s5F1CoF7SCCjYovvfJnpn9+5
	YUGF3VQ0s/6c5IBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/percpu: Make CONFIG_USE_X86_SEG_SUPPORT work
 with sparse
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87v7gz0yjv.ffs@tglx>
References: <87v7gz0yjv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176874844148.510.15534678654047778598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bbef8e2c29c32f048fac8e07f884f827d028f1da
Gitweb:        https://git.kernel.org/tip/bbef8e2c29c32f048fac8e07f884f827d02=
8f1da
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 18 Jan 2026 15:45:40 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 15:54:17 +01:00

x86/percpu: Make CONFIG_USE_X86_SEG_SUPPORT work with sparse

Now that sparse builds enforce the usage of typeof_unqual() the casts in
__raw_cpu_read/write() cause sparse to emit tons of false postive
warnings:

 warning: cast removes address space '__percpu' of expression

Address this by annotating the casts with __force.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/87v7gz0yjv.ffs@tglx
Closes: https://lore.kernel.org/oe-kbuild-all/202601181733.YZOf9XU3-lkp@intel=
.com/
---
 arch/x86/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 725d0ef..c55058f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -137,12 +137,12 @@
=20
 #define __raw_cpu_read(size, qual, pcp)					\
 ({									\
-	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
+	*(qual __my_cpu_type(pcp) * __force)__my_cpu_ptr(&(pcp));	\
 })
=20
-#define __raw_cpu_write(size, qual, pcp, val)				\
-do {									\
-	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) =3D (val);	\
+#define __raw_cpu_write(size, qual, pcp, val)					\
+do {										\
+	*(qual __my_cpu_type(pcp) * __force)__my_cpu_ptr(&(pcp)) =3D (val);	\
 } while (0)
=20
 #define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)


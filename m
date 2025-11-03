Return-Path: <linux-tip-commits+bounces-7212-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5CC2C8F2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DB03BEBE0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406753254BE;
	Mon,  3 Nov 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSeE8fhj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ctDWzaVQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84F325482;
	Mon,  3 Nov 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181291; cv=none; b=e3omi3jS/eLuPlkXZP4nXyNkAZWFAO35r/aHb1/QPV5i3asEsQHNyRh6S4wYxdPQtdVTt/9HsX+FqvGr0O0t4EdfPylQq+BPmZXxTTs0jqFsL6sLqr837kazmw2pEN+FsWp8RE/Ij3fswxWCwBNGkNwfA2IMeUvp/3j54NnVh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181291; c=relaxed/simple;
	bh=3sGdwdhely1tsnt4154TGA8xOpC/p2tmw5SRelWyAOw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LfzB6FDKXupu7GmQeAEBNLpZ64rj2lZ4BkZLEe1+vJSOLhz+ojdLcRUmGQ9SxjNVW/xO3YrxwJQ9l5IVw2/MJJkCX0aTfIpiwiKDs119sRbzuONqbPk4UgkxOF9/Ch63Z72ucGArawWXJ7za9Owzsj03/KA/+d57ZrkuO0vATOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSeE8fhj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ctDWzaVQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8/GJG1Biwhf23Q005/mfbP8zl1E/C9X63YIebXOD7s=;
	b=MSeE8fhjhX4CWgvtsQb30ICmxJeJQ+8pARoRkjV3fRWB5nVgYyyV04Y+Xt9uXrcAJjhXe6
	zdD8ANbBF6HEZDDZfVEs/WnBl2dzQxbzQ1PRPtCm8xl2xd+344LMjynpnxUB9G72mh4Mqh
	N0EQw1rdYTlh/Pw/C9xT9mTcfJo4ZcuQh+2bvbVZqH3mLn2xfQR1WHpNbfqu+pgr2cEAAL
	8hWY1CRRehnAtOwAfVm2W6u+blTECnOLoOxN3zcNZP7raE9QBmRRvZTnF5mBR3TgBXBtse
	byPMTa6cR/ktow/7BzPT186Fye1uweqI3PNGrFDBC853NRjpzarNP72SVliEcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8/GJG1Biwhf23Q005/mfbP8zl1E/C9X63YIebXOD7s=;
	b=ctDWzaVQ7cC8/wWhyh47iNXCV+XmVndqMSyimMjhoiX4Ky8QcxLDRuaQq0lvbhl023UpC9
	tJ7xCRvQ9tRzMdCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] s390/uaccess: Use unsafe wrappers for ASM GOTO
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.483079889@linutronix.de>
References: <20251027083745.483079889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218128694.2601451.2804543144721289061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     43cc54d8dbe6b761bd2672bf9bb46e5290e90277
Gitweb:        https://git.kernel.org/tip/43cc54d8dbe6b761bd2672bf9bb46e5290e=
90277
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:10 +01:00

s390/uaccess: Use unsafe wrappers for ASM GOTO

ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

bool foo(u32 __user *p, u32 val)
{
	scoped_guard(pagefault)
		unsafe_put_user(val, p, efault);
	return true;
efault:
	return false;
}

It ends up leaking the pagefault disable counter in the fault path. clang
at least fails the build.

S390 is not affected for unsafe_*_user() as it uses its own local label
already, but __get/put_kernel_nofault() lack that.

Rename them to arch_*_kernel_nofault() which makes the generic uaccess
header wrap it with a local label that makes both compilers emit correct
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://patch.msgid.link/20251027083745.483079889@linutronix.de
---
 arch/s390/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 3e5b8b6..c5e02ad 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -468,8 +468,8 @@ do {									\
=20
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT && CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAG=
S */
=20
-#define __get_kernel_nofault __mvc_kernel_nofault
-#define __put_kernel_nofault __mvc_kernel_nofault
+#define arch_get_kernel_nofault __mvc_kernel_nofault
+#define arch_put_kernel_nofault __mvc_kernel_nofault
=20
 void __cmpxchg_user_key_called_with_bad_pointer(void);
=20


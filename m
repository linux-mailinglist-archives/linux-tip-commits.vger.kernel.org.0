Return-Path: <linux-tip-commits+bounces-7088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E448C19C6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0775D1C866CF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4234EF15;
	Wed, 29 Oct 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R1puTSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaX5FxtQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE934DCC9;
	Wed, 29 Oct 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733455; cv=none; b=b31iujQmqKgyrk3NHb7Ho6SSXOWIoWzY5WF3P8Tc/3HvF3RHX6WCnM1JqaKBZEeoz4ssTeDhhHV33/zwPly5e3E54uFhZE56bFwAGxtddGQBjTof3C2W8Wr+1XJcpbrDnf9ExTY8uuVXzJgUIIq75rg+NsCSCfvNbgUQXj3N6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733455; c=relaxed/simple;
	bh=juMu4w0Qr0SwctRlSHk4dVPIOJpajwK0FD2Q21Pk8O4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TF+jFKE367jXW9DCS+uxVpICSLvLqgB2bkvqzcCI+KO61PZuYuLv88sWowJ5kHqFwUt7pb4pgL3XWNd1C93C5rJ5E7akPqpt5d7ftx00Rx8/9H/C3nBWqr1MglcBz9KhIpF/egKqu/wd18oKKIgY2jYHHrQqziMYWrypQncKrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R1puTSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SaX5FxtQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhELoioaSleXVrwAZsOyAEtxvcXcrwEOkzUMjacH87A=;
	b=1R1puTSMJ3qhFG4F94avHacln7lxlNrXJXAtZrrbMo0ENVqSfi8fGaCkK0zCVE+uaaYkSc
	VBUqu7jLahZ9ruzYrNJmWpv2UoAXz+3mNIP181VsQetkWSO60RPR5Gl9qVp9S0lJlKdNKp
	T9qt+rurq5h7gQZUZULmALQp0zYOuNCTWfPH4s8aodrKn6h0hKZTwo2mOvGAB3NaoW9MYj
	e+JMCK2F5mMbA30lSa/gkCXlofg8lTcDwupg8imlGAjxI4fT4SDB5V80RLF0BAJJXDJOc6
	SgoZcNdcbi/jxyEhnAD+9y0bsTYnH+WtI4zyy4G0yAvEZdfuIEV3LZssBmqx/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhELoioaSleXVrwAZsOyAEtxvcXcrwEOkzUMjacH87A=;
	b=SaX5FxtQ6emXze+ovUm29eL9TfsdXCSeLnqiH+Xfhqaq9wzHZihipuC0q2kACW6oSIxNRc
	cWIgcSg5c+juC8Aw==
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
Message-ID: <176173345017.2601451.5300987106730295859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     6c5957fa71461c088a95df7772e640ab8b1e3bf3
Gitweb:        https://git.kernel.org/tip/6c5957fa71461c088a95df7772e640ab8b1=
e3bf3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:43:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:09 +01:00

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


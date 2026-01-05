Return-Path: <linux-tip-commits+bounces-7783-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E81CF2D28
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 10:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D975830053E6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F1336EF5;
	Mon,  5 Jan 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ju0xflHJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JrGSVr6+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525C336EEC;
	Mon,  5 Jan 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606437; cv=none; b=QjjDz+lO6m6ux3zq2V7UFlFbeWsYdp40NKTMq7m66YRe1FlMYFyCpnqBjd83gZErZOOCcVphCSk6crCYDX3qUZ60I4EB7JNvY326v1HfHL55CXQPRZte/8K37uigdZiooKXo6645EUD8KMudakPZxyyZTDtKGTSOKhXSJ+ELwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606437; c=relaxed/simple;
	bh=cRRtIsIokPs5svNsko77noa5PA8pn6/U30uAIxXdT08=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z6P2uRrBLyYODuxYp0w/ijeI2UKDEtKozED/1AlQbAF5KaXFsegzWhXXG/hgfTp4Ws0Nn9qOg7yJG8O35RxMmhXyM8dCKSvyk312tSiKcUvggZqc0AMqKyKUEKwhZq5MWcg9nkNm1kaZuVpAydSqR194yxuPMaGBJNToKPknPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ju0xflHJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JrGSVr6+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 09:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767606433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN3tgilZ1jhKWzZ4AnZmBuPTaPIQF1zk7+urnl/PaVE=;
	b=Ju0xflHJeL2gS9X6/ixjf8XQjWAXue7ybAe34dswpqQ3mqd73VSx273w5QH3+/l7aVRUam
	1YKBP1CwgEQiNqc04XkCmhwIQtDp1obWjt765PUWnS1O0Wvhq4JDR4dcthF1xDxjOOGq9F
	raQT/i+WMA5sMKuZ3+N7Fbs2ZYsSrhytGdkf4pFcYcJ4nSJrWVi11PN++M7Of8cpPARCod
	UogxyyBV12qUQ6aXUmlWo0CC/tkFBsPeFxvOYed6AxQgzlqy0yV4jRxQxO8hWCzUECYZfF
	4EBUxTpg1O3UPAV86iWTUI5Zuuq3XHJPTVcW8RpkfhOkS/svdcye14Rt9WzoqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767606433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN3tgilZ1jhKWzZ4AnZmBuPTaPIQF1zk7+urnl/PaVE=;
	b=JrGSVr6+r7TOMzsu6cJk6e1uT4q4oFp4YObYDolbfljMtV7ZXG0GyLHIgFr4RvzKSmxlp7
	lJqRmeiSwpdklHAw==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Disable GCOV on noinstr object
Cc: Brendan Jackman <jackmanb@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Marco Elver <elver@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251216-gcov-inline-noinstr-v3-3-10244d154451@google.com>
References: <20251216-gcov-inline-noinstr-v3-3-10244d154451@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176760643216.510.5051258374257648101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9efb74f84ba82a9de81fc921baf3c5e2decf8256
Gitweb:        https://git.kernel.org/tip/9efb74f84ba82a9de81fc921baf3c5e2dec=
f8256
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Tue, 16 Dec 2025 10:16:36=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 10:22:48 +01:00

x86/sev: Disable GCOV on noinstr object

With Debian clang version 19.1.7 (3+build5) there are calls to
kasan_check_write() from __sev_es_nmi_complete(), which violates noinstr.  Fix
it by disabling GCOV for the noinstr object, as has been done for previous
such instrumentation issues.

Note that this file already disables __SANITIZE_ADDRESS__ and
__SANITIZE_THREAD__, thus calls like kasan_check_write() ought to be nops
regardless of GCOV. This has been fixed in other patches. However, to avoid
any other accidental instrumentation showing up, (and since, in principle GCOV
is instrumentation and hence should be disabled for noinstr code anyway),
disable GCOV overall as well.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20251216-gcov-inline-noinstr-v3-3-10244d154451=
@google.com
---
 arch/x86/coco/sev/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 3b8ae21..b2e9ec2 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -8,3 +8,5 @@ UBSAN_SANITIZE_noinstr.o	:=3D n
 # GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
 KASAN_SANITIZE_noinstr.o	:=3D n
 KCSAN_SANITIZE_noinstr.o	:=3D n
+
+GCOV_PROFILE_noinstr.o		:=3D n


Return-Path: <linux-tip-commits+bounces-6554-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE9B52A2B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E837B6ADB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238C279DC0;
	Thu, 11 Sep 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TUtixv/s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbT4MP3B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C92773C7;
	Thu, 11 Sep 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576104; cv=none; b=IIozR6nBQ2CBVdemlJi25cZSHQarCafwLtf9ArC4Zeq1TqP+T/ei/pCnTNM3uuO8r8NSls5m9nGLozbO5lleD29wljf/I8OBSp8iFIu2VAaDUkY7/ppPxa8ox7FBNa9332d+xcxFf2pw8lUmJsyPeskJP5e5HqDBCvMbqiHs4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576104; c=relaxed/simple;
	bh=6AkqX+dYxIhNykIzGe8qNljFHhuZBLlb8L29Pjp4kwE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hAkJPkM/YZuqZ5qzc6VqwC09SjSl18mvfx131gP9pLoKoCDMjItq73ExmXmvpntfscKlrbtDI9frgWaVkNbrUlvhQDS+l8oTya6FJdv+NGMoOoAIBJXa1Pbz5AfUrSisoI2CUMBV/hUz5oC8NO43EGiES0O4NWfLvCd3OkijrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TUtixv/s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbT4MP3B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:35:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dS3W9Aj5AS005Rnsgj3MDzHjavecNcvZESlBTdHWmww=;
	b=TUtixv/sP+wgxvIVikjCI2vu9WG3aNqxBFzVVhr5MLwdre6wasAIiopqiZfuyDxn4e8h2x
	YpJKCLG3ALncUS7DG2qZGgrFvfvzJxlUfI+1mmmPoJP/qMmMw+j+D00b35hOJn5tjlmHXj
	Pe9nkddllX/SgG8QoO0Yek1va/dxovvYCIWrciwTFBX4+5mhx1+EIQH2GRt28FQnlOcbVP
	LpgpF9Dqs0QUtzee6WpVmF1XW9F/u53CqTghs7aSjmP4GF+0X6h1kbrQy1OnW/a29YLnvo
	GcjGPpIqX3FydDiLIesIfZmOIH6T4qScRH26LlqX9Uj4EqBbF64U+NireOIs7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dS3W9Aj5AS005Rnsgj3MDzHjavecNcvZESlBTdHWmww=;
	b=BbT4MP3BEEgjMUZPYnb/Cxc0CrM5ApI8R2GbDqqL7PShg8pgiN/cLYoxZqSB9ArvJpspXe
	/7w9FRfbq34TswDQ==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] compiler_types.h: Move __nocfi out of
 compiler-specific header
Cc: Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757610011.709179.5506163533242194344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     038c7dc66e2744e5df57163b8f957745ae10d23e
Gitweb:        https://git.kernel.org/tip/038c7dc66e2744e5df57163b8f957745ae1=
0d23e
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 20:46:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:07 +02:00

compiler_types.h: Move __nocfi out of compiler-specific header

Prepare for GCC KCFI support and move the __nocfi attribute from
compiler-clang.h to compiler_types.h. This was already gated by
CONFIG_CFI_CLANG, so this remains safe for non-KCFI GCC builds.

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250904034656.3670313-1-kees@kernel.org
---
 include/linux/compiler-clang.h | 5 -----
 include/linux/compiler_types.h | 4 +++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index fa4ffe0..7a4568e 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -96,11 +96,6 @@
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
=20
-#if __has_feature(kcfi)
-/* Disable CFI checking inside a function. */
-#define __nocfi		__attribute__((__no_sanitize__("kcfi")))
-#endif
-
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1675543..a910f9f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -432,7 +432,9 @@ struct ftrace_likely_data {
 # define __noscs
 #endif
=20
-#ifndef __nocfi
+#if defined(CONFIG_CFI_CLANG)
+# define __nocfi		__attribute__((__no_sanitize__("kcfi")))
+#else
 # define __nocfi
 #endif
=20


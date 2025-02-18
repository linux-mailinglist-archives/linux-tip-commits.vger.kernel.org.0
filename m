Return-Path: <linux-tip-commits+bounces-3505-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADCAA39BD9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE743A684D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A352417F5;
	Tue, 18 Feb 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAjzlFu2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgKejc4q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1752417C5;
	Tue, 18 Feb 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880706; cv=none; b=Zma6IZWOcfhdlhd65TR53BlpqG4M7ZMXRvSB7L6oug6RrtUcVCY9vuUAiQ/dLPWUblqIjY5SkyXvkdS5BIbTb4R7z2a98FvKYWTrYwBBKKOmXnDrz5UWHchBQsvyWpjRcZQgh9JXJMKJOv/UtVkUAVYdJtzQrlFlZIhT0tRtpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880706; c=relaxed/simple;
	bh=TaXcCCFiQ+7staJgU8+rwOlfZ7g2bCDXmVRSnvmDjA8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hye0MN3+5N/J+B1X0Ohm9lQaCfyuJdHRp8NH0XedXWw5Te8r6n6JXPfNqNCFQhWRKeRjiTJJwnbzoL23HPI8Pr3VZhx4/HiB0S4N8RzotO+LE1w+s3VBfIlD3/E0urab9DpqSSFLPwKBW3Ji+YO0Z6lQ1n+YGq5tMA11tKeLZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAjzlFu2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgKejc4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrlMk9u2FDJp9duIGacGI9FvMebsGJGBoUGohA8x/7I=;
	b=sAjzlFu2qzVSExi/odDSjaDpuedYmH3rsixHhQ65+782s7ypEt1uACJU9MhKp2mF8UxwUj
	HBMUCVooatQidoA1XDJ7Ru82QT5Hy5sYurdum6pqnwStSp/cYjswU271e1dA30lRXATkDg
	cFEvBpNYkk0Lwll0sPRf9+syP/HxQY/n1zRKOnxgYiV8E2k5X9hp4LJxNA0BkoCzZgqCTu
	HfybsfXofYxj79tmk3xG9anQcH+vpP4p7XJkUlv/CR4xYMvvH8YwUbCOLH3gsQSMKtssvY
	fSZ0ad06vIasVUXohUP6/1/N1/vR1x3CB/8RNoko7SeoZ7qmh1/q3LKLsMU4+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrlMk9u2FDJp9duIGacGI9FvMebsGJGBoUGohA8x/7I=;
	b=jgKejc4qe/rArYSgcG2NF8w/8lUP6NjD8ylGcKJ9enyX9R1p7oZr4yTMrdvrDBQ6Iwk1u6
	uED/DotWj+9bUQCg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] percpu: Remove PER_CPU_FIRST_SECTION
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-13-brgerst@gmail.com>
References: <20250123190747.745588-13-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070299.10177.12068715152153299676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     95b0916118106054e1f3d5d7f8628ef3dc0b3c02
Gitweb:        https://git.kernel.org/tip/95b0916118106054e1f3d5d7f8628ef3dc0b3c02
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:53 +01:00

percpu: Remove PER_CPU_FIRST_SECTION

x86-64 was the last user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-13-brgerst@gmail.com
---
 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/percpu-defs.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 02a4adb..a3c77a1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1062,7 +1062,6 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
  */
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 5b520fe..40d34e0 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -26,13 +26,11 @@
 #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
 #endif
-#define PER_CPU_FIRST_SECTION "..first"
 
 #else
 
 #define PER_CPU_SHARED_ALIGNED_SECTION ""
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
-#define PER_CPU_FIRST_SECTION ""
 
 #endif
 
@@ -115,16 +113,6 @@
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
 /*
- * Declaration/definition used for per-CPU variables that must come first in
- * the set of variables.
- */
-#define DECLARE_PER_CPU_FIRST(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-#define DEFINE_PER_CPU_FIRST(type, name)				\
-	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-/*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
  * data corresponds to a particular CPU, inefficiencies due to direct access by


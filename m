Return-Path: <linux-tip-commits+bounces-3928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB51A4DAEC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8926B7A292A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2682040B0;
	Tue,  4 Mar 2025 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0fuCrH7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oEcuID3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDB202F65;
	Tue,  4 Mar 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084599; cv=none; b=E2khrxS7ho2n5FNINcctZWVnvAYagjssOsaHMjMMMAEAumywSZoRAmI4Hn64EJNbzrO58s6tQnB5IZb/y2VVEvffuI+foro+bU5FbzJgq71g2Imk+4kGyUOb2W68iwD69xE6Q+joaBDgnumr4ea0MXmI70X93qw9Be/yHnMLlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084599; c=relaxed/simple;
	bh=cVLrw44xjJRSaEzFEAyiT1rNyrU2ZSOnINtE9hkR/3c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WrTCB2GmL2djyqg/eqJ1vupzI05Rumndl/+twJCrwLbUphNSbPzIeJlz/SxNzzFGbCEvRwjzudQHGMw3spNv/sjCoUI1TvHQ0tzKoJMaIJh6OnRE1WGqCW3zhfpG/PAA+P+xTN3SPndmNz7G/mw+RxjhWJdqYEInMh1YCGXjSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0fuCrH7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oEcuID3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Msj3Ve0LTQaTUUUvd5PBNfNinjh8Q/wsxezn7Nm5X4=;
	b=d0fuCrH755YQRY+YIhE5lY6Cn9i8nhJxYf41/wOFzVJ/vXknUkSoLbY8cGyk35zAtV/mg4
	FtYgnVdpqwUpH1K0XA2jsexUid6k/n5h4WuBTmmkZDCRl0OT/SpBNs933ipXuQsOu2ODvb
	Xd0+HruFImoAokdTB/i3WQWkA35PilZb2c5WCLkEStYCTj89oZO3ZwO5qvGwZHvhq7yLxe
	NG+T9yb+M+D4kZqUX2UJbIdJuzKgHwkC20JJ6lFHETbHIhvOLmtOHT5OKAoFjRRqQKlfdk
	JzehfaoKHmanY75Nlvowv5t/4De0dKypPag4gKvYOzLCau2CIKZd5sl2sw5Eyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Msj3Ve0LTQaTUUUvd5PBNfNinjh8Q/wsxezn7Nm5X4=;
	b=3oEcuID3PT9cWsVpSqwfvp9OztGOrhJjWIhOoUwa5WHvmtlzbM9rBkBlLtBwhe9id163Mg
	lRR7gZlkV/+vfDBw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] percpu: Introduce percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-2-brgerst@gmail.com>
References: <20250303165246.2175811-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108459478.14745.16503190698513195117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     120df9cb53f01237fdc4bfc8798d51442fe82311
Gitweb:        https://git.kernel.org/tip/120df9cb53f01237fdc4bfc8798d51442fe82311
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:36 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:28 +01:00

percpu: Introduce percpu hot section

Add a subsection to the percpu data for frequently accessed variables
that should remain cached on each processor.  These varables should not
be accessed from other processors to avoid cacheline bouncing.

This will replace the pcpu_hot struct on x86, and open up similar
functionality to other architectures and the kernel core.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-2-brgerst@gmail.com
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 include/linux/percpu-defs.h       | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b32e453..c4e8fac 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -385,6 +385,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	__nosave_end = .;
 
+#define CACHE_HOT_DATA(align)						\
+	. = ALIGN(align);						\
+	*(SORT_BY_ALIGNMENT(.data..hot.*))				\
+	. = ALIGN(align);
+
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
 	*(.data..page_aligned)						\
@@ -1065,6 +1070,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
+	__per_cpu_hot_start = .;					\
+	*(SORT_BY_ALIGNMENT(.data..percpu..hot.*))			\
+	__per_cpu_hot_pad = .;						\
+	. = ALIGN(cacheline);						\
+	__per_cpu_hot_end = .;						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
@@ -1112,6 +1122,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
 		PAGE_ALIGNED_DATA(pagealigned)				\
+		CACHE_HOT_DATA(cacheline)				\
 		CACHELINE_ALIGNED_DATA(cacheline)			\
 		READ_MOSTLY_DATA(cacheline)				\
 		DATA_DATA						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 40d34e0..0fcacb9 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -113,6 +113,19 @@
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
 /*
+ * Declaration/definition used for per-CPU variables that are frequently
+ * accessed and should be in a single cacheline.
+ *
+ * For use only by architecture and core code.  Only use scalar or pointer
+ * types to maximize density.
+ */
+#define DECLARE_PER_CPU_CACHE_HOT(type, name)				\
+	DECLARE_PER_CPU_SECTION(type, name, "..hot.." #name)
+
+#define DEFINE_PER_CPU_CACHE_HOT(type, name)				\
+	DEFINE_PER_CPU_SECTION(type, name, "..hot.." #name)
+
+/*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
  * data corresponds to a particular CPU, inefficiencies due to direct access by


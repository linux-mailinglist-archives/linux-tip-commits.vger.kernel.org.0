Return-Path: <linux-tip-commits+bounces-3990-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4453A4EDBB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D473AAD89
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D927BF92;
	Tue,  4 Mar 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QyvpApyq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hw4d06Bi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A5278146;
	Tue,  4 Mar 2025 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117442; cv=none; b=qxb0WHyW02P3q5A5hcU4dBwdHpWh15oESFfeG/H6h99c8VG1hzwravrPVb0Cry6797SVVjpwAWRMdwNR/qyQVXS6UWvtzKOnT+sOEifcEkbwSiHuaK1jRcwMdHpil/PZjQq1jXOc1msFNlPYdDCNA8VOPDFMbMT8TNM5+bILVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117442; c=relaxed/simple;
	bh=TCuFq6rnKiqA8FZI/m1q4J5jdHgSjKcMB5/PWjRIZK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lXasHqC1cUKRqrohncbpn0KnewoA6NHT/pY/pmFy6PWOSEMK3Sax3RqFmDlQt4G9ARePSzW4JbVZM+IoQu3FBB4MYUY1UlC0JpaBnAAGp9jbW/IzHQT0Bmk3XyJUv+Hw6xLoVTaL1p9PMDTM/GYRc3Xt2G9yU/e/88Qmmsk++cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QyvpApyq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hw4d06Bi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741117438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBuByQx1rs3aL7EfvA1FX4xLhJHpjef2EMWCqlyZ4MU=;
	b=QyvpApyqftEs1yysYpgHlN3frWGEQrK6Wqxad/1NVfum38l9UMVk3W/snLwDux8x/fWjW4
	iXXcpyHnSck7Rs5+SrqBWmXgKNdB9vIjo3sZQxyVAQ6iOwfVLISnOO+SDdLA4CnNCTzhIf
	aEHRiQWGXbv13RgqG4ktgSM+CLEnNvBHwBe8qaepgev9nvvtFQZMnTQDfNP9pN4rE007+A
	Dl0s3nRO/xVLngV0Y/GIwEjdK/2aZcXBP2KV5sYZ+gPxPO0laA4PELmikcw6PgFJYUznLl
	7yY9Gnm0ObRk+nUjDdffBbLGQyuTKvKYaQLNOHwR5PYQ/IFkwqAUaUMHPbgsUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741117438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBuByQx1rs3aL7EfvA1FX4xLhJHpjef2EMWCqlyZ4MU=;
	b=Hw4d06Bi00vMpvhn74N7bsl1g9DnwBiaozpYXxRagLn7kYAADP+XDMPuj8DFESzm7aUXIU
	G5TjV/aHE7HOSmBg==
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
Message-ID: <174111743821.14745.6882309467873511423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ab2bb9c084f7e3b641ceba91efc33b3adcd1846e
Gitweb:        https://git.kernel.org/tip/ab2bb9c084f7e3b641ceba91efc33b3adcd1846e
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:36 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:30:33 +01:00

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


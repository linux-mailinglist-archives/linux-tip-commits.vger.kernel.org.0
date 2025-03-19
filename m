Return-Path: <linux-tip-commits+bounces-4377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B7A68AD4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691BF7A4ED9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61225E478;
	Wed, 19 Mar 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IoW2q9Gi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zNcWDL8m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00025DAFF;
	Wed, 19 Mar 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382242; cv=none; b=jAtuUDKS1t194eehAlEmCV2ULLAuefI/j4eEP5JibhYFlmtIaGWneTFeNm6KxW09VYhKWO/ColPNl2V4Jihx32DAsErtOWCuyULYKjtt6wW/m0X5H0ou4FBE9gd3kehHJDFyqK8KagivDwu94fumkt5YEXgYMY3JovMJ0/CdT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382242; c=relaxed/simple;
	bh=e4OvErSlT0uQZ9MD7YSZVIHAxqGzDZ/nOGOZ9qAu4iw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZT+y2aro471cbcpNJX/ZlpTBiFZC3BqrXqHAUUAbFy8MSoCbtPvWdjtEviSoPUtlVM5sUpX0u8Ie4lwaE68Jtd0Nn5TFxG6QfnqgYYrZTFDvzfzMnGYlyGIkeIZJMaUUBY4wxXCjtqVREyCKnh8p4Yv7MKCqIP7AuT+lYz28FJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IoW2q9Gi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zNcWDL8m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg2e835c06FzzW0dU7Y20AEPrUlio9XwlXCJF5+w/PY=;
	b=IoW2q9Gizal1txpUXI4W8zNVx1zqX3qb1OcCPmXM8p8cjUHxGVfYh7jWihtzLFrefrXm5L
	j204qu9YVGlW0L62u28IcdMqdjAMR2HmRgaCwtKxVbvqnbb3nKLqa6G3k3VUIhOEhLVk4e
	A56WDbz6ez+jHP9eTo+abU1n8rl6BACDjzZr3vpNkK/mTXVk4BdPjfcm1n/4Hv7IG3iDeq
	NanQIdl+WU7rmL70Vc5F75UvugIupzFt35Er7ZLKpURpDPHA7WX/M8HtQigGgUsUYSZ/Wk
	X7k6ntFm8PPJ9Q8fTv/IrR/EouxbjLvMgSMVWPaiNw4YL2s8M2uN6q7Yg6Tfww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg2e835c06FzzW0dU7Y20AEPrUlio9XwlXCJF5+w/PY=;
	b=zNcWDL8mBO63t94Ygmk/NBRucPmd1nqqwuPGeb3RQ28HdO04Sweze5JXGeUc4gV90aRVpH
	OwX2C+16d8uwZrDg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Shorten CPU matching macro
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311-add-cpu-type-v8-2-e8514dcaaff2@linux.intel.com>
References: <20250311-add-cpu-type-v8-2-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223732.14745.9864693420927390557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c3390406adc62dd2d42eb522e1ce124fa43c5dec
Gitweb:        https://git.kernel.org/tip/c3390406adc62dd2d42eb522e1ce124fa43c5dec
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:16:46 +01:00

x86/cpu: Shorten CPU matching macro

To add cpu-type to the existing CPU matching infrastructure, the base macro
X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE need to append _CPU_TYPE. This
makes an already long name longer, and somewhat incomprehensible.

To avoid this, rename the base macro to X86_MATCH_CPU. The macro name
doesn't need to explicitly tell everything that it matches. The arguments
to the macro already hint at that.

For consistency, use this base macro to define X86_MATCH_VFM and friends.

Remove unused X86_MATCH_VENDOR_FAM_MODEL_FEATURE while at it.

  [ bp: Massage commit message. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250311-add-cpu-type-v8-2-e8514dcaaff2@linux.intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 110 ++++++--------------------
 1 file changed, 26 insertions(+), 84 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 9ebc263..45489b0 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -57,7 +57,7 @@
 #define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
 
 /**
- * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
+ * X86_MATCH_CPU -  Base macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
  *		The name is expanded to X86_VENDOR_@_vendor
  * @_family:	The family number or X86_FAMILY_ANY
@@ -74,19 +74,7 @@
  * into another macro at the usage site for good reasons, then please
  * start this local macro with X86_MATCH to allow easy grepping.
  */
-#define X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
-						    _steppings, _feature, _data) { \
-	.vendor		= X86_VENDOR_##_vendor,				\
-	.family		= _family,					\
-	.model		= _model,					\
-	.steppings	= _steppings,					\
-	.feature	= _feature,					\
-	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
-	.driver_data	= (unsigned long) _data				\
-}
-
-#define X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
-						    _steppings, _feature, _data) { \
+#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _data) { \
 	.vendor		= _vendor,					\
 	.family		= _family,					\
 	.model		= _model,					\
@@ -97,24 +85,6 @@
 }
 
 /**
- * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Macro for CPU matching
- * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
- *		The name is expanded to X86_VENDOR_@_vendor
- * @_family:	The family number or X86_FAMILY_ANY
- * @_model:	The model number, model constant or X86_MODEL_ANY
- * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
- * @_data:	Driver specific data or NULL. The internal storage
- *		format is unsigned long. The supplied value, pointer
- *		etc. is casted to unsigned long internally.
- *
- * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
- * set to wildcards.
- */
-#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
-	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
-						X86_STEPPING_ANY, feature, data)
-
-/**
  * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
  * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
  *		The name is expanded to X86_VENDOR_@vendor
@@ -123,13 +93,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)	\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family,		\
-					   X86_MODEL_ANY, feature, data)
+#define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)		\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
+		      X86_STEPPING_ANY, feature, data)
 
 /**
  * X86_MATCH_VENDOR_FEATURE - Macro for matching vendor and CPU feature
@@ -139,12 +106,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)			\
-	X86_MATCH_VENDOR_FAM_FEATURE(vendor, X86_FAMILY_ANY, feature, data)
+#define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)				\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, X86_FAMILY_ANY, X86_MODEL_ANY,	\
+		      X86_STEPPING_ANY, feature, data)
 
 /**
  * X86_MATCH_FEATURE - Macro for matching a CPU feature
@@ -152,12 +117,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_FEATURE(feature, data)				\
-	X86_MATCH_VENDOR_FEATURE(ANY, feature, data)
+#define X86_MATCH_FEATURE(feature, data)					\
+	X86_MATCH_CPU(X86_VENDOR_ANY, X86_FAMILY_ANY, X86_MODEL_ANY,		\
+		      X86_STEPPING_ANY, feature, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
@@ -168,13 +131,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set to wildcards.
  */
-#define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)		\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,	\
-					   X86_FEATURE_ANY, data)
+#define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)			\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,	\
+		      X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM - Match vendor and family
@@ -184,12 +144,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is casted to unsigned long internally.
- *
- * All other missing arguments to X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
- * set of wildcards.
  */
-#define X86_MATCH_VENDOR_FAM(vendor, family, data)			\
-	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, X86_MODEL_ANY, data)
+#define X86_MATCH_VENDOR_FAM(vendor, family, data)				\
+	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -197,15 +155,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * Stepping and feature are set to wildcards
  */
-#define X86_MATCH_VFM(vfm, data)			\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM(vfm, data)						\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm),	VFM_MODEL(vfm),		\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
@@ -217,16 +170,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * feature is set to wildcard
  */
-#define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(		\
-		VFM_VENDOR(vfm),				\
-		VFM_FAMILY(vfm),				\
-		VFM_MODEL(vfm),					\
-		__X86_STEPPINGS(min_step, max_step),		\
-		X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)			\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
+		      __X86_STEPPINGS(min_step, max_step), X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -235,15 +182,10 @@
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.
- *
- * Steppings is set to wildcard
  */
-#define X86_MATCH_VFM_FEATURE(vfm, feature, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		X86_STEPPING_ANY, feature, data)
+#define X86_MATCH_VFM_FEATURE(vfm, feature, data)				\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
+		      X86_STEPPING_ANY, feature, data)
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);


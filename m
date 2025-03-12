Return-Path: <linux-tip-commits+bounces-4132-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA88A5D9FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 10:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDF61744AD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C223FC40;
	Wed, 12 Mar 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmyYyqlH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlZd06D/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305523E35E;
	Wed, 12 Mar 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773290; cv=none; b=iyVC3Z2LdRNkC1Dn0aOBoYb1dc1XDERjqddflJHWe0pND9nY5e4UBl4EzjjW5/WOk1Yt5Iztl07LdvdEMrBvmSPa5NRYz+G/X8eatKNkOk7oPKjMA/oOkXjr4ZYj/8ypssJAP+ZCdJua6KJldOMMuHTC+zR+6NDolf/x5LpNSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773290; c=relaxed/simple;
	bh=7oYtQ5u9810BAduP1mdWSKZnTdy+IqcoRgA+JYIyT+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eZ5HY/WT++YUYXD1x1hVHCGXLVNS+macg/+9ryJbwYT+TAgVV0IkB4DC+apiKaKobqhJalBHzO0LYh4Cq8F92cLYl0DRTMtObN4O8OcqAm0DIy/3Gz1Uwn2R1w4i0LNDoayq02tjDRPxO0XUmSCWy21tcChgDZRgab/IZXxe9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmyYyqlH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlZd06D/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 09:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741773285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6s4Am1KqQV2YxS+hYODVjskUgADTGssQXrQg4n4GbU=;
	b=NmyYyqlHxAoTIy+Quapg6MUmN1JDDwdptoWAllf9ZPDS42E893r7IQ9ZTlBTJ2rMwrmMiw
	W9BOQMPSTuqVjzbv9InehCpJYMykXxVSS8OgF/nW3Q9h/rvX96AU/5x0uXvVQ+zYqKIjZT
	VXwJ9NGyurbnWv/ooa+aFQnl/Vt3+AJ4PGORsjPZOjnSEXZ5vZutGN6pAHqVk8/X9byqXY
	EMRKvt8h7y5boVIwbcnFlZno2FD9bMoiDMuWtszd+B0WXgyr/Jr9BXunBxUCTVnSLFdEQp
	uM7YSlAuiB/+T2wcedMqzvbFUORhFFd+UQIxcEFDF9IeVWBqBdGU+cX4CDaRXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741773285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6s4Am1KqQV2YxS+hYODVjskUgADTGssQXrQg4n4GbU=;
	b=MlZd06D/UFCEAciGd/exmt3fgjS3qvNOzoPyJCcdLiqNPPRnwlccMjy3J4g+jofzNNHOAz
	hrR5YncTTcc7S6Bw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Shorten CPU matching macro
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
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
Message-ID: <174177328489.14745.11811097110184780206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6f91e60c38443f80c7d41aab3f535390f758d35f
Gitweb:        https://git.kernel.org/tip/6f91e60c38443f80c7d41aab3f535390f758d35f
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:20 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Mar 2025 20:53:30 +01:00

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


Return-Path: <linux-tip-commits+bounces-4129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61809A5DA01
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F077A4B63
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84323F382;
	Wed, 12 Mar 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cr7Pqf5y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKpGatbd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBD23C8C2;
	Wed, 12 Mar 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773288; cv=none; b=nGQ9GTjE+O/wI8rumLW5NrUbvfpv4vgLXNWCyVkpavFgIUtWisLIQf5MEdFp1WTRsWovuGbhgyNcDGC8Qd36FoejRzNwZkteIH7vgxJZ03B8DePwtzoR6boRzEk+KO0phsms1UJ1n9WFX+R4K0nXy+6haIVpDSGgtWQUQrCYg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773288; c=relaxed/simple;
	bh=KdBVRiCBoWXfyp8cdmZJ1KGObUj8uq+OROiBfxiWlGE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cBOId+taWdw8W4sMj8rX8sTdj1M4jWSTZDPghOOZqsFBi1uN28uXnREvkphU+Gi4TUZWH6JG8r563oh/Ndp/S3YL7HxvEiftVC1VFdg1VF5t3MIL2NKFi9TbGyy0NqLhoFJ437BJdJ0V8YO3+vZOOe6cCvehUC6FcPowpkcgnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cr7Pqf5y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKpGatbd; arc=none smtp.client-ip=193.142.43.55
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
	bh=5YubjklCKyWO3ECMuLBwPNXaOU0rfVBpEJ5SKv7cL3g=;
	b=cr7Pqf5yHMGgsP3xveu4LmHdelGJ10E6Vb0+2lnprE31GiFZ4Lvu0bHUlZv9sUZgkO7dTo
	BVyiU7tUZSwMOXqbWVzX1dLBFfbqZcUO0HTG+gRH0kj/k5x25JXg+W8wSCgrWnmnWf89Hp
	VNnqA6ctoEaqE3P/M5fVZsIG5CivZQj6wEkq1Mafs3dvaMTa55J0+L1HzWR00LrYYdrNai
	fQIIxMksZJTwljr9wEhOonmc5/jk2nQkWcddwhKra1GmNDfGYU2nNrYoQyIA709b+88jbH
	RQ3uVEGjsNCooafvgjWa5nvF2gv3+XO/i+yaP5+sSqkDGHMMI0whFL67XOUOdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741773285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YubjklCKyWO3ECMuLBwPNXaOU0rfVBpEJ5SKv7cL3g=;
	b=IKpGatbdGj4z5FAAfyHiz7RTSmkbjFYnnLWoU3ztUNOJ0TuWDu/oIgKPaL7Gh7qLhCQqFz
	cOHWFO+cCusJprDA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add cpu_type to struct x86_cpu_id
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311-add-cpu-type-v8-3-e8514dcaaff2@linux.intel.com>
References: <20250311-add-cpu-type-v8-3-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174177328429.14745.17373093589223626208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     72e6cc4356393b7d8ceef7e9a74acce3f24cd04a
Gitweb:        https://git.kernel.org/tip/72e6cc4356393b7d8ceef7e9a74acce3f24cd04a
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:36 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Mar 2025 20:53:30 +01:00

x86/cpu: Add cpu_type to struct x86_cpu_id

In addition to matching vendor/family/model/feature, for hybrid variants it is
required to also match cpu-type. For example, some CPU vulnerabilities like
RFDS only affect a specific cpu-type.

To be able to also match CPUs based on their type, add a new field "type" to
struct x86_cpu_id which is used by the CPU-matching tables. Introduce
X86_CPU_TYPE_ANY for the cases that don't care about the cpu-type.

  [ bp: Massage commit message. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250311-add-cpu-type-v8-3-e8514dcaaff2@linux.intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 32 +++++++++++++++++++--------
 include/linux/mod_devicetable.h      |  2 ++-
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 45489b0..6be777a 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -74,13 +74,14 @@
  * into another macro at the usage site for good reasons, then please
  * start this local macro with X86_MATCH to allow easy grepping.
  */
-#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _data) { \
+#define X86_MATCH_CPU(_vendor, _family, _model, _steppings, _feature, _type, _data) { \
 	.vendor		= _vendor,					\
 	.family		= _family,					\
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
 	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
+	.type		= _type,					\
 	.driver_data	= (unsigned long) _data				\
 }
 
@@ -96,7 +97,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)		\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FEATURE - Macro for matching vendor and CPU feature
@@ -109,7 +110,7 @@
  */
 #define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)				\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, X86_FAMILY_ANY, X86_MODEL_ANY,	\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_FEATURE - Macro for matching a CPU feature
@@ -120,7 +121,7 @@
  */
 #define X86_MATCH_FEATURE(feature, data)					\
 	X86_MATCH_CPU(X86_VENDOR_ANY, X86_FAMILY_ANY, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
@@ -134,7 +135,7 @@
  */
 #define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)			\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,	\
-		      X86_FEATURE_ANY, data)
+		      X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VENDOR_FAM - Match vendor and family
@@ -147,7 +148,7 @@
  */
 #define X86_MATCH_VENDOR_FAM(vendor, family, data)				\
 	X86_MATCH_CPU(X86_VENDOR_##vendor, family, X86_MODEL_ANY,		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
@@ -158,7 +159,7 @@
  */
 #define X86_MATCH_VFM(vfm, data)						\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm),	VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, X86_CPU_TYPE_ANY, data)
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
@@ -173,7 +174,8 @@
  */
 #define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)			\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      __X86_STEPPINGS(min_step, max_step), X86_FEATURE_ANY, data)
+		      __X86_STEPPINGS(min_step, max_step), X86_FEATURE_ANY,	\
+		      X86_CPU_TYPE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
@@ -185,7 +187,19 @@
  */
 #define X86_MATCH_VFM_FEATURE(vfm, feature, data)				\
 	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),		\
-		      X86_STEPPING_ANY, feature, data)
+		      X86_STEPPING_ANY, feature, X86_CPU_TYPE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_CPU_TYPE - Match encoded vendor/family/model/type
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @type:	CPU type e.g. P-core, E-core
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ */
+#define X86_MATCH_VFM_CPU_TYPE(vfm, type, data)				\
+	X86_MATCH_CPU(VFM_VENDOR(vfm), VFM_FAMILY(vfm), VFM_MODEL(vfm),	\
+		      X86_STEPPING_ANY, X86_FEATURE_ANY, type, data)
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index d67614f..bd7e60c 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -692,6 +692,7 @@ struct x86_cpu_id {
 	__u16 feature;	/* bit index */
 	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
 	__u16 flags;
+	__u8  type;
 	kernel_ulong_t driver_data;
 };
 
@@ -703,6 +704,7 @@ struct x86_cpu_id {
 #define X86_STEP_MIN 0
 #define X86_STEP_MAX 0xf
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
+#define X86_CPU_TYPE_ANY 0
 
 /*
  * Generic table type for matching CPU features.


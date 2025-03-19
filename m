Return-Path: <linux-tip-commits+bounces-4375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC9A68ACD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA037AD73B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354025E453;
	Wed, 19 Mar 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o8qnVbzQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ynvkPsKE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63D25D918;
	Wed, 19 Mar 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382241; cv=none; b=Bo9rbooV9Bvhbh7pBqlaLyZlEx7DqGDt2PXqTwO5YtKZM5ZPgab59KlTnclJkrDRfm9o0JmcfJqex8VcaKc9KuJpdS0fIbbyBilrRUnVxiXj2IcBELc91tg3cRq9tcCQnrvwgmrRbaHzbCvSPZDUpCue980pzsFCxfsV1gFxSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382241; c=relaxed/simple;
	bh=9DQdigSnh/86lBA85I/YOPVMDNpXcxf/sTpaFWx+oZk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s+QBX3Vz8XHj3dqfleysvqYcRkzllzslZ1gD9hGbYXxKOYz4Wjn0wriLgqPG5IaH7jVgBAdtNbvZGvFs4N0f1dPGBAgW7/b9ABAYiOpjBVGGsuGeM/cmDcCvxaZH/c2ikb2j7WzXv/K7CcDQQaSLFjuU6gLD2HNhFLxPSXCi2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o8qnVbzQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ynvkPsKE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/+xIBg9H/GGQC9qzRLnFLUHtHhKqucErYOvsLsi1+w=;
	b=o8qnVbzQawj0fO+dKRy2YYcmmqYpuJJK35822VDmVVSX5oeoqzcT7XiXW64/+Rf/FYCy8c
	bp2+0mWOSMay17humAYEJ+YhUDzrvEh22lw+q9FcEvclmfSSJKJSPVbORfXeGVP6xfhyDo
	u7MqbAb0ChOMO0Ge+oCeQzViPv1RbzO30Uff1nApIl0YOawXr9JfjEcGqlXXEzinLysUNK
	acU8+bh9kYMvK7qjwxhPTJclEVhRAkLb9/EO108Wpd/qwxKS5uiJZLeBo+I8qhwFFdtKmm
	a45XUA4GYA8svOQ2pCao0Z8EMWJMEB31AEMz7+BfYbACoglPy2/6yNlxN3HYpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/+xIBg9H/GGQC9qzRLnFLUHtHhKqucErYOvsLsi1+w=;
	b=ynvkPsKECSw5HVOzv2lVGOmhyjr2KtkcV7pxWM2l/cI/e+2libfESTNUd5HL3bmlvR9gL7
	aTSh/FAUc+xYB2Cw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Add cpu_type to struct x86_cpu_id
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <174238223677.14745.4728402080325037253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     00d7fc04b703eb3e9d61dd3eac02a34c466e9f12
Gitweb:        https://git.kernel.org/tip/00d7fc04b703eb3e9d61dd3eac02a34c466e9f12
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:36 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:17:03 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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


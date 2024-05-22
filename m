Return-Path: <linux-tip-commits+bounces-1284-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B38CBE78
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED512824D7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6A7FBC4;
	Wed, 22 May 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zt2DsWUl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oh08JwbD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10381721;
	Wed, 22 May 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371228; cv=none; b=BnFa0a6IlItdMJHQjP3YmQ7iO994Va7TmjjfEZZJqNnqG5bVVjTMxSDLW0EgQc8x3/58xrtrIKnItELhoJXKszxbyIsGP8Ts7QaHiVCujwdQGyeLJa+3msmBBfhjQjPqIR3bu7ft4APNKHilgHrSv0WiIgw3k/uoA3vVHgn8n0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371228; c=relaxed/simple;
	bh=9bH5UtwVNn9nICzxLIRIbfHQYR4U41F2jgkEuHp5D4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h2oL+kqPUjmdQ5iFJ6P9/JMq54mfcsWcCh+4MKDg6T04mAh4lwr/H+0m3fieJSGp1qQowTiKBwlSegsAG7xnJPiQsfySTzxAcM1RMH/WmyPnMmKlZ5XSxtApH9KuwlK0l6Rx2CBIPMwhIlfPAs1Hs3Auy3o0fNQV5uzgOO5urmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zt2DsWUl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oh08JwbD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 May 2024 09:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716371225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJjvIh1So52Uu8jC23qRITcBGsHdfOJSfO4XQIWrX2g=;
	b=Zt2DsWUlLBR3VU5gCfk9NWzb2erZAQ6CjN6wQyztLYHNryDmRlY2ee/hju4G6iGPw4C98d
	ykItcJtVtsVtBZlxTpTQvhKHUKcPlJUI4pO8ukIW4kjLbzYOJ5l9AM3mUBs7T6IzeBRiAq
	u5JI1x9ecwfYuNBK0oTVJ6jJa+mdx45se8s9r69munIjtftT8hK870ZVgC22jFRXoVHbZO
	WtapNLk5VmbxsP+SRlsLte5n8kU5xCU66u/dniDNNolCFEx3+aqfK5p4c3ABysEVqQ3Q2Z
	9/CIR+5cd2nRxhz8/lDFd107nS/erBk9p0S3oWsxpB9Ajk7+w1z20076LZ60RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716371225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJjvIh1So52Uu8jC23qRITcBGsHdfOJSfO4XQIWrX2g=;
	b=Oh08JwbDvWd3ADa8l41e8oX52XiiSRpNdQUzVersyxoVubsK+6BBF4X24WKnbfIBnRxruD
	hbR67DxlOhSDZXDA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,  <stable+noautosel@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240517144312.GBZkdtAOuJZCvxhFbJ@fat_crate.local>
References: <20240517144312.GBZkdtAOuJZCvxhFbJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171637122476.10875.17865590798146315700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     93022482b2948a9a7e9b5a2bb685f2e1cb4c3348
Gitweb:        https://git.kernel.org/tip/93022482b2948a9a7e9b5a2bb685f2e1cb4c3348
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:45:33 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 22 May 2024 11:31:10 +02:00

x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

Code in v6.9 arch/x86/kernel/smpboot.c was changed by commit

  4db64279bc2b ("x86/cpu: Switch to new Intel CPU model defines") from:

  static const struct x86_cpu_id intel_cod_cpu[] = {
          X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),       /* COD */
          X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),     /* COD */
          X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),             /* SNC */	<--- 443
          {}
  };

  static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  {
          const struct x86_cpu_id *id = x86_match_cpu(intel_cod_cpu);

to:

  static const struct x86_cpu_id intel_cod_cpu[] = {
           X86_MATCH_VFM(INTEL_HASWELL_X,   0),    /* COD */
           X86_MATCH_VFM(INTEL_BROADWELL_X, 0),    /* COD */
           X86_MATCH_VFM(INTEL_ANY,         1),    /* SNC */
           {}
   };

  static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  {
          const struct x86_cpu_id *id = x86_match_cpu(intel_cod_cpu);

On an Intel CPU with SNC enabled this code previously matched the rule on line
443 to avoid printing messages about insane cache configuration.  The new code
did not match any rules.

Expanding the macros for the intel_cod_cpu[] array shows that the old is
equivalent to:

  static const struct x86_cpu_id intel_cod_cpu[] = {
  [0] = { .vendor = 0, .family = 6, .model = 0x3F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [1] = { .vendor = 0, .family = 6, .model = 0x4F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [2] = { .vendor = 0, .family = 6, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 1 },
  [3] = { .vendor = 0, .family = 0, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 0 }
  }

while the new code expands to:

  static const struct x86_cpu_id intel_cod_cpu[] = {
  [0] = { .vendor = 0, .family = 6, .model = 0x3F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [1] = { .vendor = 0, .family = 6, .model = 0x4F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [2] = { .vendor = 0, .family = 0, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 1 },
  [3] = { .vendor = 0, .family = 0, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 0 }
  }

Looking at the code for x86_match_cpu():

  const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
  {
           const struct x86_cpu_id *m;
           struct cpuinfo_x86 *c = &boot_cpu_data;

           for (m = match;
                m->vendor | m->family | m->model | m->steppings | m->feature;
                m++) {
       		...
           }
           return NULL;

it is clear that there was no match because the ANY entry in the table (array
index 2) is now the loop termination condition (all of vendor, family, model,
steppings, and feature are zero).

So this code was working before because the "ANY" check was looking for any
Intel CPU in family 6. But fails now because the family is a wild card. So the
root cause is that x86_match_cpu() has never been able to match on a rule with
just X86_VENDOR_INTEL and all other fields set to wildcards.

Add a new flags field to struct x86_cpu_id that has a bit set to indicate that
this entry in the array is valid. Update X86_MATCH*() macros to set that bit.
Change the end-marker check in x86_match_cpu() to just check the flags field
for this bit.

Backporter notes: The commit in Fixes is really the one that is broken:
you can't have m->vendor as part of the loop termination conditional in
x86_match_cpu() because it can happen - as it has happened above
- that that whole conditional is 0 albeit vendor == 0 is a valid case
- X86_VENDOR_INTEL is 0.

However, the only case where the above happens is the SNC check added by
4db64279bc2b1 so you only need this fix if you have backported that
other commit

  4db64279bc2b ("x86/cpu: Switch to new Intel CPU model defines")

Fixes: 644e9cbbe3fc ("Add driver auto probing for x86 features v4")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable+noautosel@kernel.org> # see above
Link: https://lore.kernel.org/r/20240517144312.GBZkdtAOuJZCvxhFbJ@fat_crate.local
---
 arch/x86/include/asm/cpu_device_id.h | 5 +++++
 arch/x86/kernel/cpu/match.c          | 4 +---
 include/linux/mod_devicetable.h      | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 970a232..b6325ee 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -53,6 +53,9 @@
 #define X86_CENTAUR_FAM6_C7_D		0xd
 #define X86_CENTAUR_FAM6_NANO		0xf
 
+/* x86_cpu_id::flags */
+#define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
+
 #define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
@@ -79,6 +82,7 @@
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
+	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
 	.driver_data	= (unsigned long) _data				\
 }
 
@@ -89,6 +93,7 @@
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
+	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
 	.driver_data	= (unsigned long) _data				\
 }
 
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 8651643..8e7de73 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -38,9 +38,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	const struct x86_cpu_id *m;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	for (m = match;
-	     m->vendor | m->family | m->model | m->steppings | m->feature;
-	     m++) {
+	for (m = match; m->flags & X86_CPU_ID_FLAG_ENTRY_VALID; m++) {
 		if (m->vendor != X86_VENDOR_ANY && c->x86_vendor != m->vendor)
 			continue;
 		if (m->family != X86_FAMILY_ANY && c->x86 != m->family)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 7a9a07e..4338b1b 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -690,6 +690,8 @@ struct x86_cpu_id {
 	__u16 model;
 	__u16 steppings;
 	__u16 feature;	/* bit index */
+	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
+	__u16 flags;
 	kernel_ulong_t driver_data;
 };
 


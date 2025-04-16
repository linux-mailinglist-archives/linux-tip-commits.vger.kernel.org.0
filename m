Return-Path: <linux-tip-commits+bounces-5010-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8AFA8B342
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E025A33CA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC104235342;
	Wed, 16 Apr 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPjRsGDB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYYuu806"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2618233738;
	Wed, 16 Apr 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791447; cv=none; b=UgthjIeINjr6CW8AeMY317VtD8ZKMVWlFntl5xg7n9LkYGOcgJ+Q14IOBA4dQBT/yWdMeT/ux9LYUWj4CwkrydeNDORxJ5dLK1L3tjPGdKgQz617sPFyqWkSmP8NiEleOuF1PWp/OJziGoce9yySn7ri9zUzAZ7F4a0R15KmHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791447; c=relaxed/simple;
	bh=qPEg1KySudesSEVSFb0zsyILwjvmw0RMXGLMvVoYGSc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=luzXA/B1QBs1jXYhBClCLpmrL1FP3jixLqW9YEA2k8rOPQAMWtW0oAbtBdfrvHZEs829jDXOn2cku5KUP4w86h5TbCwzg/9gk/DrBAPgm5v9QeujnKGgor1xx2M/KbgGzXVr7dtboYT3ul1o4n8CZa3XnJXEicPEako3VAG3aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPjRsGDB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYYuu806; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDMJzW5pG+qxKAqsh0VAMg/e3q1AWmqOhVRJ/CqPqQ8=;
	b=GPjRsGDBk91apthLjhGUkvLcyBjZLHEQJbn32EKMVvzuaskho1TrwOOVFCUvf/LejyLfut
	Op+MKfTWCldBnhP8tKx6kJra7catsCGu69NbISYVtDvS4FzJoOCWm5eZ2OqU87WEkZ+6Gc
	ThT/OHXBAsIhF4g18BylqqBnQGUA9vHJ0XhrQm5k8NkusfvtC+ZZ91oBjqy+ja5XIRjvFr
	Iw5SQW+r47w1gq7vjRB3gCeq8hza85FXqXg9Ip8ll1z4GFN+gJEdPtWjsJRLEK2hdHJ/e7
	cu3T+WBNIZgpdkKG+yPHEyYnlwGqC3TuqvePKEBIEL3fABW/aXMlZBvF+6JT1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDMJzW5pG+qxKAqsh0VAMg/e3q1AWmqOhVRJ/CqPqQ8=;
	b=DYYuu806gw6sT1sAa7im3jx+TOfqpyqJdVitdJn8/s0Dsk4uzs7UsYKVPc7frPMVapvg2e
	vJEhj7tsw2OPGKCg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/apx: Define APX state component
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-3-chang.seok.bae@intel.com>
References: <20250416021720.12305-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479144336.31282.17761360795556750675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     bd0b10b795c5c4c587e83c0498251356874c655c
Gitweb:        https://git.kernel.org/tip/bd0b10b795c5c4c587e83c0498251356874c655c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:44:14 +02:00

x86/fpu/apx: Define APX state component

Advanced Performance Extensions (APX) is associated with a new state
component number 19. To support saving and restoring of the corresponding
registers via the XSAVE mechanism, introduce the component definition
along with the necessary sanity checks.

Define the new component number, state name, and those register data
type. Then, extend the size checker to validate the register data type
and explicitly list the APX feature flag as a dependency for the new
component in xsave_cpuid_features[].

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-3-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/types.h |  9 +++++++++
 arch/x86/kernel/fpu/xstate.c     |  3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index de16862..97310df 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -125,6 +125,7 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_16,
 	XFEATURE_XTILE_CFG,
 	XFEATURE_XTILE_DATA,
+	XFEATURE_APX,
 
 	XFEATURE_MAX,
 };
@@ -145,6 +146,7 @@ enum xfeature {
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 #define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
 #define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
+#define XFEATURE_MASK_APX		(1 << XFEATURE_APX)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
@@ -304,6 +306,13 @@ struct xtile_data {
 } __packed;
 
 /*
+ * State component 19: 8B extended general purpose register.
+ */
+struct apx_state {
+	u64				egpr[16];
+} __packed;
+
+/*
  * State component 10 is supervisor state used for context-switching the
  * PASID state.
  */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a288597..dfd07af 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -63,6 +63,7 @@ static const char *xfeature_names[] =
 	"unknown xstate feature",
 	"AMX Tile config",
 	"AMX Tile data",
+	"APX registers",
 	"unknown xstate feature",
 };
 
@@ -81,6 +82,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
+	[XFEATURE_APX]				= X86_FEATURE_APX,
 };
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
@@ -569,6 +571,7 @@ static bool __init check_xstate_against_struct(int nr)
 	case XFEATURE_PASID:	  return XCHECK_SZ(sz, nr, struct ia32_pasid_state);
 	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
 	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
+	case XFEATURE_APX:        return XCHECK_SZ(sz, nr, struct apx_state);
 	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
 	default:
 		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);


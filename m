Return-Path: <linux-tip-commits+bounces-4399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28909A69A86
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 22:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CFD1897D10
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BC221B9F5;
	Wed, 19 Mar 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9ti/9ti";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r57+fuWI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DED21ABD2;
	Wed, 19 Mar 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418050; cv=none; b=N/whVQ3vbCIuy5hd/w7cIuxXwLnxTF+9Zlp9f1w7QFRqeXocaNFCFzgh65CtrRpcIsrNl3W9AMnE2fObJ3X1bAEZe9BDXGfWKnOACYqZe7hAyK7Ut+mFmOXN3uXMW/R+44NrHsMpShcSdU9oV1Mf9xPqKZ0IyFin1jYVEN90PC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418050; c=relaxed/simple;
	bh=97OtnsfXX7Xd9n2VVlpERMRzPJBTmKis4gnPYTI1FZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FQS+hdrpa24QoeD9CRv7sLjVmiDPGf5hAAdfmffH/vUaYPhZBFuXrooXY9vZtxS75Il57iQ4Ttj6DjwvpTSyQWXk1kxDKmhcy3yIfO3jQM2hoJrVw+lF/SX/dOnDIYNnCGuQC+x1ZC/yZuu3evNFlc3N7+1t/1BnrW7hCLKvcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9ti/9ti; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r57+fuWI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 21:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742418047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/jcQ6Y8L55T8elzmTbLaawoTT2ppFSIu2z29CFWSo=;
	b=c9ti/9tiIRbXwgEehGkFDAK4odN5zL0O/uObbeCEd7SYuKiZgijdr2Mqrn+iPOHGCZyDQ7
	FdxKhSuPmjCYM9vjT5legEfBr8xUFLnLTxvLjVFnjSJNIcSg6T8MnpMbkvDN38z/NdDL2V
	QzHo3Ozv6bdrAJ/E2i2zVNSLqHxMnxOnbdiIjuaJxvYZL8QcJpPaigubKRhHPFWcItsPCA
	R6Uho3L9sN+oSVsrmsUzFi1srSgrARbvyMHPEz0dGGEIv53hdy+q6Nb+Hp31BCwykzvizU
	+Sir+vkqPHtzlTXmKICAVmwuMFuFx5tcpiq+vVfqrFdjaECdeZ8Bl2rj4zw5/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742418047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/jcQ6Y8L55T8elzmTbLaawoTT2ppFSIu2z29CFWSo=;
	b=r57+fuWIB1FJ2qUqD1bPjKg338zbuh11tuupsjW9TrqDDJfY6n6YNg8sICcFfzZrSTfudP
	dJ0g3ZLQv3C88+Cg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] perf/x86/intel, x86/cpu: Replace Pentium 4 model
 checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250318223828.2945651-3-sohil.mehta@intel.com>
References: <20250318223828.2945651-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174241804621.14745.893771608753364718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     de844ef582e3a5e0cbd429c68b6079eeb87394e5
Gitweb:        https://git.kernel.org/tip/de844ef582e3a5e0cbd429c68b6079eeb87394e5
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Mar 2025 22:38:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 21:34:10 +01:00

perf/x86/intel, x86/cpu: Replace Pentium 4 model checks with VFM ones

Introduce a name for an old Pentium 4 model and replace the x86_model
checks with VFM ones. This gets rid of one of the last remaining
Intel-specific x86_model checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250318223828.2945651-3-sohil.mehta@intel.com
---
 arch/x86/events/intel/p4.c          | 7 ++++---
 arch/x86/include/asm/intel-family.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 844bc4f..fb726c6 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -10,6 +10,7 @@
 #include <linux/perf_event.h>
 
 #include <asm/perf_event_p4.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hardirq.h>
 #include <asm/apic.h>
 
@@ -732,9 +733,9 @@ static bool p4_event_match_cpu_model(unsigned int event_idx)
 {
 	/* INSTR_COMPLETED event only exist for model 3, 4, 6 (Prescott) */
 	if (event_idx == P4_EVENT_INSTR_COMPLETED) {
-		if (boot_cpu_data.x86_model != 3 &&
-			boot_cpu_data.x86_model != 4 &&
-			boot_cpu_data.x86_model != 6)
+		if (boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT &&
+		    boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT_2M &&
+		    boot_cpu_data.x86_vfm != INTEL_P4_CEDARMILL)
 			return false;
 	}
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6cd08da..3a97a7e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -193,6 +193,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
 #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */


Return-Path: <linux-tip-commits+bounces-6342-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E708B33C8C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FE1189DB97
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D22DF3FB;
	Mon, 25 Aug 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYiqVOBX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMlvKPVF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11872DCC01;
	Mon, 25 Aug 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117473; cv=none; b=MsXL/F72VEqJbkfMuSwITS2nKF9/2A8iibgTA3X7nKKWVFqi5KQhuN/3YGqhCEDLVVg+rBT5Sfnv5g8q/vE5CMh47LAO6Plzk9y9Vlp0ZAMy2U7rWyL+hm3t127EsCzgQ0rneMfViSNIptLqaOqfEaNFnBN6xLkDM5kNufYKpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117473; c=relaxed/simple;
	bh=HxxdoXI3Bf5f8Hj2WvBRlTY7KUViZVV6EIAFRVkAnWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ayCnLtG4UHeBIrJHOCux0jrvVnPKCIiBSnqiQpOiHlVAA3Hs0JX8zCx6UGUVo4FTD6I+GSJn2KXigtP+4PgMKSIaV9mt1TVF9FQlZ23J4IQw0OnQ7YsP0A+LdldTz6ZwA7O+EkqfLnQ/gJJljbV5fiLI1zGyeywMrdQERnAZlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYiqVOBX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMlvKPVF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhnM/vHIJXnjfNOBNngOMU1xX4jgTromQ0OYFC7Ej4U=;
	b=WYiqVOBXHjPV0j471swD2Zo8wvv5HytXKkr6IJmLTLXuyy3r1p8bUfpIBmjf+QTWMPE5mi
	irEl6kK2gJ58Pn+T/kzxh1sWqAiR5yQKpU11O28cgrO8z4+JfQ2m6uhHc8x30UmexEl5X3
	5UYYwy5UcCZiz9N5zFt9tEt8SYSaH3DjhKJnBpepDpV0iOLp6YMrgh6yv5Vv17wm+PT07Z
	bTxf1S6aQt6PO0hQIkBDGXnIDLISmtWdZME78Uv3jFm27hzStCDhzv24lbEm0UUyX4o+N1
	lyzxbxQSJNJlW0pS9qnlOqSPaiJ4oMTsu9fp4N02vFpERM1Ry1EqeG868qnk0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhnM/vHIJXnjfNOBNngOMU1xX4jgTromQ0OYFC7Ej4U=;
	b=ZMlvKPVFnIhR5xr3urr0y/KSwVHmyeCbssNrObLPMKiviNrlCie4gnfa/ApDt7gN+TQdib
	vVuCRrvLhJf54FCA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820023032.17128-3-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611746850.1420.5279678492721434998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     43796f30507802d93ead2dc44fc9637f34671a89
Gitweb:        https://git.kernel.org/tip/43796f30507802d93ead2dc44fc9637f346=
71a89
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 20 Aug 2025 10:30:27 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:27 +02:00

perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error

When running perf_fuzzer on PTL, sometimes the below "unchecked MSR
 access error" is seen when accessing IA32_PMC_x_CFG_B MSRs.

[   55.611268] unchecked MSR access error: WRMSR to 0x1986 (tried to write 0x=
0000000200000001) at rIP: 0xffffffffac564b28 (native_write_msr+0x8/0x30)
[   55.611280] Call Trace:
[   55.611282]  <TASK>
[   55.611284]  ? intel_pmu_config_acr+0x87/0x160
[   55.611289]  intel_pmu_enable_acr+0x6d/0x80
[   55.611291]  intel_pmu_enable_event+0xce/0x460
[   55.611293]  x86_pmu_start+0x78/0xb0
[   55.611297]  x86_pmu_enable+0x218/0x3a0
[   55.611300]  ? x86_pmu_enable+0x121/0x3a0
[   55.611302]  perf_pmu_enable+0x40/0x50
[   55.611307]  ctx_resched+0x19d/0x220
[   55.611309]  __perf_install_in_context+0x284/0x2f0
[   55.611311]  ? __pfx_remote_function+0x10/0x10
[   55.611314]  remote_function+0x52/0x70
[   55.611317]  ? __pfx_remote_function+0x10/0x10
[   55.611319]  generic_exec_single+0x84/0x150
[   55.611323]  smp_call_function_single+0xc5/0x1a0
[   55.611326]  ? __pfx_remote_function+0x10/0x10
[   55.611329]  perf_install_in_context+0xd1/0x1e0
[   55.611331]  ? __pfx___perf_install_in_context+0x10/0x10
[   55.611333]  __do_sys_perf_event_open+0xa76/0x1040
[   55.611336]  __x64_sys_perf_event_open+0x26/0x30
[   55.611337]  x64_sys_call+0x1d8e/0x20c0
[   55.611339]  do_syscall_64+0x4f/0x120
[   55.611343]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

On PTL, GP counter 0 and 1 doesn't support auto counter reload feature,
thus it would trigger a #GP when trying to write 1 on bit 0 of CFG_B MSR
which requires to enable auto counter reload on GP counter 0.

The root cause of causing this issue is the check for auto counter
reload (ACR) counter mask from user space is incorrect in
intel_pmu_acr_late_setup() helper. It leads to an invalid ACR counter
mask from user space could be set into hw.config1 and then written into
CFG_B MSRs and trigger the MSR access warning.

e.g., User may create a perf event with ACR counter mask (config2=3D0xcb),
and there is only 1 event created, so "cpuc->n_events" is 1.

The correct check condition should be "i + idx >=3D cpuc->n_events"
instead of "i + idx > cpuc->n_events" (it looks a typo). Otherwise,
the counter mask would traverse twice and an invalid "cpuc->assign[1]"
bit (bit 0) is set into hw.config1 and cause MSR accessing error.

Besides, also check if the ACR counter mask corresponding events are
ACR events. If not, filter out these counter mask. If a event is not a
ACR event, it could be scheduled to an HW counter which doesn't support
ACR. It's invalid to add their counter index in ACR counter mask.

Furthermore, remove the WARN_ON_ONCE() since it's easily triggered as
user could set any invalid ACR counter mask and the warning message
could mislead users.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250820023032.17128-3-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729..15da60c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2997,7 +2997,8 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_even=
ts *cpuc)
 			if (event->group_leader !=3D leader->group_leader)
 				break;
 			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_=
MAX) {
-				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
+				if (i + idx >=3D cpuc->n_events ||
+				    !is_acr_event_group(cpuc->event_list[i + idx]))
 					return;
 				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
 			}


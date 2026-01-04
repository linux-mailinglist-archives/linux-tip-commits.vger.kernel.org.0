Return-Path: <linux-tip-commits+bounces-7781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F805CF1427
	for <lists+linux-tip-commits@lfdr.de>; Sun, 04 Jan 2026 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB9C7300C5F2
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 Jan 2026 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A51E1E00;
	Sun,  4 Jan 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="phxEtDAA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+CUzDia8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B881EF36C;
	Sun,  4 Jan 2026 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554326; cv=none; b=e2u4xgq4aIRgPBEIJ+gs+3UA2FEgDem/4V95V311dP9DdNBtW4SR0heiKp44MJM9ZnMg1TY9DACKMULUEzRWGsG8Q0IxZEdG1WfoPa8sbUJh2HV+Pd7Vz93r1cKQ0iCxNPeuAg9zaOsbDGOL6Yd81XG/BdJyVFKJpAlT4fCZNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554326; c=relaxed/simple;
	bh=K/65FS1J6R/6KdrU6EYz2SryNpxz2tuS/jysHo8ZXho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NIAqAOST7Q9wl68/1c4lvRZUAm19LCTJlAXQL+oiypybB58azuyyJSTItfInScWBzKdFT4obqkcdndIOOL6sCkdnbY2YZti9rZYtWo97CwoYbMUq0yEMAJkzpFV9CPIDPqW4naF06nD7Wmf/bGrxfPrdTtvLAlO3UCXBSY9be/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=phxEtDAA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+CUzDia8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 Jan 2026 19:18:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767554316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbVp3FZIhlX7ecOLLMTUTnBv5Uj3fLmyk5Fyk4Sw9Ho=;
	b=phxEtDAADpkeEDWGW3fzPiOwYFup6F2PrHF99T7Or4ESzpt4GERkddyIIlZV0ZI6IbGZZp
	/HWuGnU9CYFKdRQfeJ5Y2DO5ZlXPZsqzqyk/xGXg0R1omDDrxN+tVys0WMW9OBMX83vF73
	U+0T9TsML1Eo4iBtr1zd2C3PWSUPi05Rk5EGNlG4vzuNm65bpQQ6l2AE3DY9hTcf588sWT
	FZv8Ur8rcLHmmnq5nOgHH68rrcdgf1lEtywA0vhA4z0EumYbcjzHtEC+Y02SMR9ivh9Sb/
	XtiBANvE6GccOD2Sy8h/wBumBPymREZiEmo3uWc7oH9btNIREQId5hjiY5oIzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767554316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbVp3FZIhlX7ecOLLMTUTnBv5Uj3fLmyk5Fyk4Sw9Ho=;
	b=+CUzDia80+4tueXO6V2+2Zqdfqqyj6nMdWyksYKtacALqPbkbVTjIfW9dHgsdJ9VJ5XWSv
	Qa3vdVQV2McCwuBA==
From: "tip-bot2 for Rong Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/split_lock: Remove dead string when
 split_lock_detect=fatal
Cc: Rong Zhang <i@rong.moe>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251215182907.152881-1-i@rong.moe>
References: <20251215182907.152881-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176755431116.510.16624657260337348261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6823f10dcc84f35ca652eff0448f7da3d3b26548
Gitweb:        https://git.kernel.org/tip/6823f10dcc84f35ca652eff0448f7da3d3b=
26548
Author:        Rong Zhang <i@rong.moe>
AuthorDate:    Tue, 16 Dec 2025 02:11:51 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 04 Jan 2026 14:26:02 +01:00

x86/split_lock: Remove dead string when split_lock_detect=3Dfatal

sld_state_show() has a dead str1 below:

  if (A) {
  	...
  } else if (B) {
  	pr_info(... A ? str1 : str2 ...);
  }

where A is always false in the second block, implied by the "if (A) else"
pattern. Hence, str2 is always used.

This seems to be some mysterious legacy inherited from the earlier patch
revisions of

  ebb1064e7c2e ("x86/traps: Handle #DB for bus lock").

Earlier revisions=C2=B9 did enable both sld and bld at the same time to detect
non-WB bus_locks when split_lock_detect=3Dfatal, but that's no longer true in
the merged revision.

Remove it and translate the pr_info() into its equivalent form.

=C2=B9 https://lore.kernel.org/r/20201121023624.3604415-3-fenghua.yu@intel.com

  [ bp: Massage commit message; simplify braces ]

Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251215182907.152881-1-i@rong.moe
---
 arch/x86/kernel/cpu/bus_lock.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index dbc99a4..fb16666 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -410,13 +410,10 @@ static void sld_state_show(void)
 		}
 		break;
 	case sld_fatal:
-		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
 			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBU=
S on user-space split_locks\n");
-		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
-			pr_info("#DB: sending SIGBUS on user-space bus_locks%s\n",
-				boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) ?
-				" from non-WB" : "");
-		}
+		else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: sending SIGBUS on user-space bus_locks\n");
 		break;
 	case sld_ratelimit:
 		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))


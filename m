Return-Path: <linux-tip-commits+bounces-3013-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19849E7882
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 20:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C01886760
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E071195FF0;
	Fri,  6 Dec 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9cZuE6G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/f1Oe+P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36C13D516;
	Fri,  6 Dec 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511758; cv=none; b=CTazmM49rLfLZMlQWEx48Dxje5Gm5fswq85JtYNnb3BXAWVUDnxR1eL3Cnc61sti2OFDEmFYuYhvBV+r6bzSwFwRUp+lY69fEzV+2fsup1oHQcMOb1Jsr6uAH7d8yu13EyZUbbeCI0bAzwav8dGjrfIq9ZuGo6nNquxU6W7mLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511758; c=relaxed/simple;
	bh=mOsEHHL7vLHUpRJBVrndf7EXabAD5NG6NwnSvg8Y0Ys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HA5qN/tonf4FTpfrVSfP0sPZ3OCyWmfp0Wh3jBLEOqfJbjfgczKDbtTmJWhLs5wHUO913WMV9CuU1LXgUrucZ0bbW5dca44gsfDufAzVqzFi15Wl3R4JfsUznXCPsVuiokeNFWQ2pzTAqGzQdKG/Py/Wn13Wv2781InRtuarH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9cZuE6G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/f1Oe+P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 19:02:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733511754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRhLd7M5uFXlGp0Tkw2VSN+PGpMwRwIrIA+DfB6yw9Y=;
	b=u9cZuE6GUkW3PnQIMLE6GIQJeYGVhMIvFdv/wmqgDjyNsyAS30OSX8EmoGkTqKuXRQka2Z
	crjClgp9jwdWAjirQ/O6taq4UY1mDOUFxYbjtAFReLVlIhbpPOZMzUtYwkuZw916JTMBs6
	FEn0rUfdLPlsPnMaF34e1uvVPTstPmnjT50A3nBhY/bbcD4qxvm/h+4xkhjwOFJ8x4ZlV4
	VfeYDm8/4jEsq1u9nU0MCdQOZJ93xuMzYgZ5qZnnoypqZ0Av69lqNBDkfIhKBITgBfozm4
	btc2V67g1Iw3s9LalaawFwLwlbhr9Brns/JFkDMmvRz1ZK9yqknCeqYZGabQdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733511754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRhLd7M5uFXlGp0Tkw2VSN+PGpMwRwIrIA+DfB6yw9Y=;
	b=x/f1Oe+PBlYwamB5nCZTRAcgVXHXnvM3zbvdMiCdWQ9UjHx6r1wXIjy1gvBFMBa9pooeNN
	UxzxRSrwLEgS3iAA==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and
 only if the WRMSR fails
Cc: Nathan Chancellor <nathan@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z1MkNofJjt7Oq0G6@google.com>
References: <Z1MkNofJjt7Oq0G6@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173351175403.412.3888951416121519088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     492077668fb453b8b16c842fcf3fafc2ebc190e9
Gitweb:        https://git.kernel.org/tip/492077668fb453b8b16c842fcf3fafc2ebc190e9
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 06 Dec 2024 08:20:06 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 19:57:05 +01:00

x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the WRMSR fails

When ensuring EFER.AUTOIBRS is set, WARN only on a negative return code
from msr_set_bit(), as '1' is used to indicate the WRMSR was successful
('0' indicates the MSR bit was already set).

Fixes: 8cc68c9c9e92 ("x86/CPU/AMD: Make sure EFER[AIBRSE] is set")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/Z1MkNofJjt7Oq0G6@google.com
Closes: https://lore.kernel.org/all/20241205220604.GA2054199@thelio-3990X
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d8408aa..79d2e17 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1065,7 +1065,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	 */
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
-		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
+		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS) < 0);
 
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);


Return-Path: <linux-tip-commits+bounces-1930-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBB9461F0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286F31C20F68
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033E136326;
	Fri,  2 Aug 2024 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQ9F2wx2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnCWtt2/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D216BE02;
	Fri,  2 Aug 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617041; cv=none; b=IIeVL5aNocYPDb4X3+0tdHe0wgNoQwl2baxeSO3gdRd0LSMjfIXA/BlelyaC8rKu4L5aEjru7cdTjizWKg9hcCKM/+4lBrZdp0ShAx6KPKt7L6xVhV1TVeiKXbpPoEI0K4r+cgA8wzX5pohz71C7VD9CRB884LKgqhyJxRYtlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617041; c=relaxed/simple;
	bh=8XEi+13NZTXueUGt3oRFjyAfKZ9s7Zm/L10469/W95Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e55uNuR4SALnfASFDXElOzxaA7om07oVyUIc6QAWmc6ehIukFg3WBcOa/2OaUvgWjEM+GSp1s93VYSR5B3pK1RiR7Y/H5rPLC6DO4pG9LtiNsPRGWmaLsGnOziKkfsVCO/SJZg/LE6waBZjwLbCMZjXYW66JRL/LQmjSYJaSSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQ9F2wx2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnCWtt2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722617038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eFvLdL7VGTMpnzwSogiL2VLEqV/4dAJ3zFB9eQYG+4=;
	b=sQ9F2wx29WuLzloImZtocO7kMCFNIYQ9UXBkFBdGlGsLk7z1ZxLWl1bjRJOyZoXnioPVRq
	3LrQlGjO5eWdeU26hG9fZjSOaH1GcVKfHhr2nWr6Ola9lLdehhmcG9jUzdZ1GQC4DMAXGL
	vzq4YCumI/QwlcWMc1dhTNdJggoUoj6dpSftZG5UEYLUyUjfEGGL8Uv8acaG1cVNkDSJwA
	2xRjfIxZ01hAamsScsDxbg2knPYamI0xP3tH2lrdaVQRAsCI0rS3PgSbw08tb5Yejh1f0k
	GBW8iadj8IpsV5qwWk2dvpfpYOREZlptqDNmo712P0qk6IambtZatuDUyuTZsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722617038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eFvLdL7VGTMpnzwSogiL2VLEqV/4dAJ3zFB9eQYG+4=;
	b=ZnCWtt2/yG9tZGnnM+3Kb8iNm4rHRM2YUuCZY1kHqtTSIkbc+Rqj2gLm5bTg3lVep8v6VG
	ud9quMv+J5KwJHCA==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/tsc: Check for sockets instead of CPUs to make
 code match comment
Cc: Zhengxu Chen <zhxchen17@meta.com>,
 Danielle Costantino <dcostantino@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802154618.4149953-5-paulmck@kernel.org>
References: <20240802154618.4149953-5-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261703803.2215.17943747116347203203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     e7ff4ebffe3bedf55560ef861d80f6500ff0d76f
Gitweb:        https://git.kernel.org/tip/e7ff4ebffe3bedf55560ef861d80f6500ff0d76f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Aug 2024 08:46:18 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:38:07 +02:00

x86/tsc: Check for sockets instead of CPUs to make code match comment

The unsynchronized_tsc() eventually checks num_possible_cpus(), and if the
system is non-Intel and the number of possible CPUs is greater than one,
assumes that TSCs are unsynchronized.  This despite the comment saying
"assume multi socket systems are not synchronized", that is, socket rather
than CPU.  This behavior was preserved by commit 8fbbc4b45ce3 ("x86: merge
tsc_init and clocksource code") and by the previous relevant commit
7e69f2b1ead2 ("clocksource: Remove the update callback").

The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
Clocksource Drivers") back in 2006, and the comment still said "socket"
rather than "CPU".

Therefore, bravely (and perhaps foolishly) make the code match the
comment.

Note that it is possible to bypass both code and comment by booting
with tsc=reliable, but this also disables the clocksource watchdog,
which is undesirable when trust in the TSC is strictly limited.

Reported-by: Zhengxu Chen <zhxchen17@meta.com>
Reported-by: Danielle Costantino <dcostantino@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802154618.4149953-5-paulmck@kernel.org

---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0ced187..dfe6847 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1288,7 +1288,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (topology_max_packages() > 1)
 			return 1;
 	}
 


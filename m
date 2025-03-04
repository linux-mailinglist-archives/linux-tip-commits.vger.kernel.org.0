Return-Path: <linux-tip-commits+bounces-3893-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA90A4DA6C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AFD1691E3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D220011B;
	Tue,  4 Mar 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kOV8EqRv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFMTeFDn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D31FE463;
	Tue,  4 Mar 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083979; cv=none; b=BtHGByFM9SQIJ0W9HxPLIXJyH13H9tkqPjKYmZlo+NHEd/tSKTGCho6HbEcOtTzLKzixO1fFXkufZ9zKYDsM7cW5VjEH1bbnn/yBkDJrRFPcB4t8b4YfKtjaGJHwx42ctQZWQnzGzMbOvd3recFOyyPDA9NX7EMZQ8AEIzzObB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083979; c=relaxed/simple;
	bh=8jKmT2Ha6mnXYYe3LWVuKr0qJsMojVDeTgqbHlBdFZw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hBMUPLxbfq2f7ax1e9BmX8X2M9yjqbrUWKxCD2rx0ITSgTAvEWzs8sPfxN15HXKkl8weNAN9n0ErcAuhrq869aZRteTWplu/QC3fHyjMG2QSE09nPq2V+Tmi6sIkPjo72BE4uBm0gUN6ZjPGoqUcUOKOwMwXspjEUgaoM6wUS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kOV8EqRv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFMTeFDn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWoxGE8iyHGbhIfOTyK5/LOzI0WcsZFtmxho7ye0wYA=;
	b=kOV8EqRv38+2lpaOvVzR/IgsTLovu8bEPIcEydnbVGC5CKcYvr8vWGOgsl7UuD7JHZ3xNg
	wdeJ1Ja5OcD16hat6nxoalA58DHpaOhOYDr25i716Z4JV28xEMR3uOvWj4b7QkIl2vZ2zM
	3DSyoCpZWFkE/ZVe43/CsKVIRwXaoHsMusSHvCk80PIeF3o6DiRKF9a/UFf1CnWBC7091b
	aBKN/NdcBXwJcx0JZvF6dZGz4Y/CFf4eIhI6As9N/1zQ2/Id4I4yFjyAn0jyC0SEWyVTRS
	jR/C3JLFcY24eTSYSQT3hIceWHTKvPgLGefevU+/cRf2spI1TALAvdiUbNMDUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWoxGE8iyHGbhIfOTyK5/LOzI0WcsZFtmxho7ye0wYA=;
	b=gFMTeFDnGXj+j8QEQX/BQYmtf9DP7G3xcxBOndOUSXNutTAw7QTDUhv0u5ajDgRMvdAgG7
	3Ouvjh5I2ZISx2DA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Remove unnecessary headers and reorder the rest
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-13-darwi@linutronix.de>
References: <20250304085152.51092-13-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108397534.14745.6476720374386091341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6309ff98f00bad118812f7f250fbbee4867e88d3
Gitweb:        https://git.kernel.org/tip/6309ff98f00bad118812f7f250fbbee4867e88d3
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:17:33 +01:00

x86/cacheinfo: Remove unnecessary headers and reorder the rest

Remove the headers at cacheinfo.c that are no longer required.

Alphabetically reorder what remains since more headers will be included
in further commits.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-13-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index eccffe2..b3a5209 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -8,21 +8,19 @@
  *	Andi Kleen / Andreas Herrmann	: CPUID4 emulation on AMD.
  */
 
-#include <linux/slab.h>
 #include <linux/cacheinfo.h>
+#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
-#include <linux/sched.h>
-#include <linux/capability.h>
-#include <linux/sysfs.h>
 #include <linux/pci.h>
 #include <linux/stop_machine.h>
+#include <linux/sysfs.h>
 
-#include <asm/cpufeature.h>
-#include <asm/cacheinfo.h>
 #include <asm/amd_nb.h>
-#include <asm/smp.h>
+#include <asm/cacheinfo.h>
+#include <asm/cpufeature.h>
 #include <asm/mtrr.h>
+#include <asm/smp.h>
 #include <asm/tlbflush.h>
 
 #include "cpu.h"


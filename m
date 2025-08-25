Return-Path: <linux-tip-commits+bounces-6343-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946F9B33C8F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80453A69F4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243642DFA3C;
	Mon, 25 Aug 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmC/1giZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7Llnfi3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F22DE6FB;
	Mon, 25 Aug 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117474; cv=none; b=hl6ZFn17hFNYJGBpyMaF6HWMY7PHweuJR2+fFi2WM5nFAfQkXUlwKTkai3KuiFG8CMscPKzHaWQ3cJQWQf1dc3NcguTSpTNyBXwQMvJV8oZOVW1Xy7qnPACeDwlsqg/MtiLp7/3bBrBs97Syc3lHp5/q3erIHrWruF9hxHxw06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117474; c=relaxed/simple;
	bh=lZoXSB6cJujo9MdoD5RqAmWEzXCE7BD+NiR+DFYuGfo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lg9VGvzYzeo92W29uHc7gz16/fmgHiwieKjLbM2oSI+TImkg1aNX1veGeC9cZ7Vl9am9s9dmxt1RJI9Ikj37Qkaq/qnCWpTiFVI1XNwcfzvJWERad3e2VJqNtZyvfC/hhuun168At2bw2TpHqwVDd17obTxFqeEZd36Cx8qMXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmC/1giZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7Llnfi3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zojrpvIkdaWsM8TBBWrFO/fK2YT46lS3BJZmKBpxq7o=;
	b=qmC/1giZOSv68Tgl03GdSKKHVN8KVgryBLLPoAw/CIWNFyW3/SykVFD1yXcE6+DM9+mRnd
	9VPiScJuLBov8qYMFYPOOT3kzp3UOkcH9mXpbYESMrErYAMpTP7Zr2iMJDCryxS/pE1yBj
	rccHRfEOQ9eD7fjYcvFuruc8MgX/Yksc2R+qDZYUF5o/yc1M4AQ4AlMaFYq0mXy/azXZBm
	XTwrBxgNg40ZsJNojd/ODIrGpttLh+ofVmxBxY9CjNBrWsTKF6zybAUYmKAT/qSxXEgX6G
	qT/IsUgSHi43CwwCaTwsDvuTUhaFDaI/qUWU+vr25gUH5DSMhiyKQTnUNNDcCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zojrpvIkdaWsM8TBBWrFO/fK2YT46lS3BJZmKBpxq7o=;
	b=I7Llnfi3UQxf+P9xLGv5Fcyn/8fn7BU8NiUXqn8/XP6TGb8+QPvTLlyJFoMHFBKC1wdGLt
	SZbjIfCsQjF+TSBg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Use early_initcall() to hook bts_init()
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820023032.17128-2-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611746972.1420.7955373348082581195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d9cf9c6884d21e01483c4e17479d27636ea4bb50
Gitweb:        https://git.kernel.org/tip/d9cf9c6884d21e01483c4e17479d27636ea=
4bb50
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 20 Aug 2025 10:30:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:26 +02:00

perf/x86/intel: Use early_initcall() to hook bts_init()

After the commit 'd971342d38bf ("perf/x86/intel: Decouple BTS
 initialization from PEBS initialization")' is introduced, x86_pmu.bts
would initialized in bts_init() which is hooked by arch_initcall().

Whereas init_hw_perf_events() is hooked by early_initcall(). Once the
core PMU is initialized, nmi watchdog initialization is called
immediately before bts_init() is called. It leads to the BTS buffer is
not really initialized since bts_init() is not called and x86_pmu.bts is
still false at that time. Worse, BTS buffer would never be initialized
then unless all core PMU events are freed and reserve_ds_buffers()
is called again.

Thus aligning with init_hw_perf_events(), use early_initcall() to hook
bts_init() to ensure x86_pmu.bts is initialized before nmi watchdog
initialization.

Fixes: d971342d38bf ("perf/x86/intel: Decouple BTS initialization from PEBS i=
nitialization")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250820023032.17128-2-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 61da6b8..cbac54c 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -643,4 +643,4 @@ static __init int bts_init(void)
=20
 	return perf_pmu_register(&bts_pmu, "intel_bts", -1);
 }
-arch_initcall(bts_init);
+early_initcall(bts_init);


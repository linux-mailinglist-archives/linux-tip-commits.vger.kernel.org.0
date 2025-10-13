Return-Path: <linux-tip-commits+bounces-6784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7150BD5287
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DAD4F3EE4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF926F44C;
	Mon, 13 Oct 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kAwPLe2F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkPoOZRk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183E23BCE7;
	Mon, 13 Oct 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369298; cv=none; b=BbyQMrdpwrhkj/dLK9lO3i6tfDHy+Gl4BhgxiUrlz9ISwNQ7X/UjkccrJPMggmmBoARS2I6Mwzea3BfnOUNARu/Q8d4YFiUvcJTnr2TwIRYTociApCcGEHaIHAN20/RCcoS0b2BSfCkz7W68NDtGI57Ts7F2V7TK4MezA+BzcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369298; c=relaxed/simple;
	bh=Z+NapRVvLUj4KbketkmIt9DRSD2RYzUsU9ILjcnOaCg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ISqPKYmn+pevjGdvfVck91ZHvEAKv5VCyk8RNYub4/v1dkul24flSmidiLB+uxT5nc23Q9a6nekGK8R+UVfqWyPJIjxFT2hZRjT7rdUgBOwamUNB8AInXvj3GCvoIXAUNWqUFVod4rSvhciEIn84pqtmzLu/vsVmVa5bnAuq75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kAwPLe2F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkPoOZRk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 15:28:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760369293;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8AdlPFIQ6z4PgveYjJ4xH2nQ9V2dwDtkHDP2mWAIvc=;
	b=kAwPLe2FttfmXsqrMxLt5Qb5sm/EasUnxc6K9zgum25fxHWE+oDxy6qzG3bWm1T+n6br4b
	58w9apV1vmJ3wvdeT70Seooo0XjFJ2E6l/0H/hmYLE5vE71fSCPqW2ihRxWSmhZaimYFQm
	ge3vfeMMayrETx/LqZIhiI9TduIZ8lYAuUnzHGOnP6zfuBeBBs+kBBLYJI2PkvCDYoCYLn
	K0InaPn5Ro+8M0AHhg4HTgB4PV6eSbbNaRwq7NpwB5CWOnmSqoC/Gcar38d53oqSHOTXB3
	0g6cXqW2/knEDWka3srIcrk1u5Bdc/s6sXbn79KwkDil0FUZLmDUUPsN1YhLXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760369293;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8AdlPFIQ6z4PgveYjJ4xH2nQ9V2dwDtkHDP2mWAIvc=;
	b=kkPoOZRkHT6MVaO4Z9WZ7/IJXLfwUIOLk9MMzhPP8hdZOeJUjqIl5B8ZXXQKRgDxzoD8jm
	QQ3wCAGTurk6/ADg==
From: "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on
 Clearwater Forest
Cc: Chen Yu <yu.c.chen@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250926041722.510371-1-yu.c.chen@intel.com>
References: <20250926041722.510371-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176036928904.709179.3903914566187770863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a0a0999507752574b80d7fbd179cce052c92791b
Gitweb:        https://git.kernel.org/tip/a0a0999507752574b80d7fbd179cce052c9=
2791b
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Fri, 26 Sep 2025 12:17:22 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Oct 2025 16:59:55 +02:00

x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on Clearwater Forest

Clearwater Forest supports SNC mode. Add it to the snc_cpu_ids[] table.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index c894561..93f4c2d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -355,6 +355,7 @@ static const struct x86_cpu_id snc_cpu_ids[] __initconst =
=3D {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, 0),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, 0),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, 0),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, 0),
 	{}
 };
=20


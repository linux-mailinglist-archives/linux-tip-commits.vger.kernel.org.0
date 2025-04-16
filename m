Return-Path: <linux-tip-commits+bounces-4999-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E67A8B207
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EDC7A7E7A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EA22A807;
	Wed, 16 Apr 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aKzUU1OJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8PVHhNaw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2758224891;
	Wed, 16 Apr 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788307; cv=none; b=SitIgd80eK170GK8Q6G1k36U4Ueum/JITiC7UfymaLYxref/jKC0smTRCBImDDpJWbIW+11lTRrm4ssS9eoQ9mE9ZrNdwhYEcp5YNqjXzb2I4RN1Kma6djdzSKKqq3HvMNdQEiNsLr1gowWkXPWF7gxc4oTzuNYJ0xWKdhEEskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788307; c=relaxed/simple;
	bh=M92aQmJ7VX2d8QnCUSlcynlJhXQbruagJDsnHZw7shs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HfIHOAm0MPYmYl9ID9tP2zOt6E1ZgGGj+j2hc8zO3Yopu3Zl+Wl8d/YELJh2Si1XHNmxuhPax1iS2ckHbmm+U3/qyrlpXI2IgbDcU04a3+tbjZXy/jXrVKlNS+bIEzT/yPxz3nBsMRiLjiqTywDPQnZg9GiB4jq8x0+3urf/Vyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aKzUU1OJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8PVHhNaw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 07:25:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744788304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H2phvnhzZ41L92DkUm1m9N/9m/cCA6TDQV+YNZF87s=;
	b=aKzUU1OJHpMDQ0vZ4JMMW5WGAoBxv7nrNp7VSQh/QeH86Ai/iC9/3J2pkLNJE4qofIxblF
	Auw9t25kx4CRuJSgdR/UpepskBJY+SgrAOGAfYOfGxv8/phoGo2ut2S+5jX81AaN/Zk9Se
	90JDaLyEahwMKYshN1pWhoHNMqx++YHBgTItQ7cUmMrdPMh+0T++tTb+5ZcCzATiRolbuN
	hPcSi9JgmJeuaIG3dMEqUL/kUpRq9mv3pnavdkRQZr3DbriLKzAG/9H7TtT9ngr254fizA
	CpXhPMYdOJXJQHfJ8qkBklqBDWYUhtPw4ImfVWiFMRc8Oycw8mDE9IdNwmQ0dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744788304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H2phvnhzZ41L92DkUm1m9N/9m/cCA6TDQV+YNZF87s=;
	b=8PVHhNawzooTlremXhE5WqADCxRKMQe9MbSIU8ziy2+eXopx3awycj4RggFW8oKEjPKSRA
	0PjyZJIovKGC99BA==
From: "tip-bot2 for Pi Xiange" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add CPU model number for Bartlett Lake
 CPUs with Raptor Cove cores
Cc: Pi Xiange <xiange.pi@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Christian Ludloff <ludloff@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Tony Luck <tony.luck@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414032839.5368-1-xiange.pi@intel.com>
References: <20250414032839.5368-1-xiange.pi@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174478830316.31282.14854889775533628837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d466304c4322ad391797437cd84cca7ce1660de0
Gitweb:        https://git.kernel.org/tip/d466304c4322ad391797437cd84cca7ce1660de0
Author:        Pi Xiange <xiange.pi@intel.com>
AuthorDate:    Mon, 14 Apr 2025 11:28:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:16:02 +02:00

x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores

Bartlett Lake has a P-core only product with Raptor Cove.

[ mingo: Switch around the define as pointed out by Christian Ludloff:
         Ratpr Cove is the core, Bartlett Lake is the product.

Signed-off-by: Pi Xiange <xiange.pi@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Christian Ludloff <ludloff@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250414032839.5368-1-xiange.pi@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 3a97a7e..be10c18 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -126,6 +126,8 @@
 #define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD) /* Redwood Cove */
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
+#define INTEL_BARTLETTLAKE		IFM(6, 0xD7) /* Raptor Cove */
+
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_LAKEFIELD			IFM(6, 0x8A) /* Sunny Cove / Tremont */


Return-Path: <linux-tip-commits+bounces-6357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D4B33CAE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05D61B219C4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16E2E5B23;
	Mon, 25 Aug 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3L0G5Yc0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+PPb0n9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1F2E5435;
	Mon, 25 Aug 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117496; cv=none; b=Jmieu7URyriVD6KC92iogwfoZv/Ca0hsM2H27GRoxRFTlVlNCXYMN1XvBystDTCSuEq7+prK4FZt7aGBhyEionxrClJXhNncm8YQvsNyG0mLTkMa8exe0G2QjSJ5NQ+Y3UzCKtdf2ryBw3UtFm5GiRCWAT7zF2Gc8X4BZD53Pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117496; c=relaxed/simple;
	bh=Dj4NRGiNTf4RR67MpcQMjJszCbvqf1SzBXdbSdqbtZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j470HkGXL1B+CqDRZTRQXygpRse6FpYvjA9L1XeiPxyPUKRsKAWtvVjjPqPJgUV5Bw6ECCXhHxAKajobNAntbptVbONcPp+XySknm4j1cRWJdiqFgK2QtjMTN6dHM/LVhhz7jwzJKEH1JadFktGQa5VoJgZrDRv4RcGv3VdW878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3L0G5Yc0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+PPb0n9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYLlFrMvbOtHyhnNijS7dPaB036AYfaevHoYeMCMejA=;
	b=3L0G5Yc08wEuwIrDIZcww/Df5RepT0X16DNAhTvholdoZsRkcdHZzR7iOw2xWSsRaQ7dIy
	YS+//Sn+vkPe0d40cja4OKrX7fvwVgUr/4kKsH7IZitnaLAbJcufoqJlHicg2wF0O8Pzv+
	THDLhioYVIj/9zb0UlEQW7ygYhhOjmlH2o/xd32GbleOlWwe0rIZFXCgDHr/10Nk7uzn1d
	j7j88kG1zWN5yvMLyjMFeCwIO8LHTZKLZ4CnEhKNuhrJy7/jqZT7HSHWq8YuBDUvSbnhae
	02i4c22bTlI5rrQiU4VX3kk5Xe/UiFewyz8L2Qt4I9/qsl0bu9YSg+F66NFYZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYLlFrMvbOtHyhnNijS7dPaB036AYfaevHoYeMCMejA=;
	b=d+PPb0n96yrQt6Hw5IuqYsS57hHDkMIcWY5VDwUoUtui+0FrlFF9Jla2hdV9shpARaYaWI
	uPVNemvCll101FBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Add SLS mitigation to the trampolines
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821123657.277506098@infradead.org>
References: <20250821123657.277506098@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749130.1420.11311386444838277257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     354492a0e1bc4a408e26ebe14166bd1064182439
Gitweb:        https://git.kernel.org/tip/354492a0e1bc4a408e26ebe14166bd10641=
82439
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Aug 2025 19:49:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:22 +02:00

uprobes/x86: Add SLS mitigation to the trampolines

It is trivial; no reason not to.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821123657.277506098@infradead.org
---
 arch/x86/kernel/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 643027e..0a8c0a4 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -336,6 +336,7 @@ asm (
 	 * call ret.
 	 */
 	"ret\n"
+	"int3\n"
 	".global uretprobe_trampoline_end\n"
 	"uretprobe_trampoline_end:\n"
 	".popsection\n"
@@ -891,6 +892,7 @@ asm (
 	"pop %r11\n"
 	"pop %rcx\n"
 	"ret\n"
+	"int3\n"
 	".balign " __stringify(PAGE_SIZE) "\n"
 	".popsection\n"
 );


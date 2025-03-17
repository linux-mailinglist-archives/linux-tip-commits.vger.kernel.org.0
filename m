Return-Path: <linux-tip-commits+bounces-4278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A6A64AB0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364057A2841
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713723814D;
	Mon, 17 Mar 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cVSo+xya";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOVMsRfm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EC23643E;
	Mon, 17 Mar 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208393; cv=none; b=qfzvPzriy35KgDYshzL5NvHqIow8fp2dSVyO8UkHFvR1QlpiZHo+jM6pt/nuObP6sPr7LxEC4381Gpye/w0KcLOND5hvDBIHrEgcN4Jp4z2+PBiiWIuFGaXyxJwP5tzCB0lh61MKJbyCPXY/OhTFKDqEO1Sv+PEdx9zy4VaN3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208393; c=relaxed/simple;
	bh=zwhKnlKzLFEZq3GNhANWORCKMx9WMhanKMVDFYkv3uc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qXfYGEnvEfBpLpszCV1m+AqUqVkTIx/s75xjROYMUnAu3cxXsEBTdQJkVFW1zsw7Ymgl8tkNoXULoGIndf7tkauGV1nZyOxgMWqz4d/mgZhbFvKRiRgYgTeGwZksZHiWWBEviHJN8sjPHP0rvVvZteoFtEI263UEWlUdff9BMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cVSo+xya; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOVMsRfm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0kEZvRnR+9787ZHiZFT95tLOuks6WuOY1JnwcC07Ak=;
	b=cVSo+xyaUkqby3SnZSWO2TdI+XhvWKrmyXoQ/geQgind36//hCm5tTcCA55lGYIqoW17QB
	SFOURkXvguAqYAdNaGG5v+6QqVwA2M17mV3dwPzq985z95YLoY/t2+dIlInsCfJM44m4L1
	j6TtdRA8eS43ej0KAqlmvEoFwkVfmPRZI51GKy+U8jmH8by6gKVOa4FwLaZ6FOUUy0c5yM
	XtYjoivINQvLjQ/qyAgiGsQRv5uc8nOsc2cHSpho937vzMPJMLuGtqfCqrKdoyP4gerTHD
	QVQ/cbw3l6zpS1ssN2kT76DS9vpgWamShh8DS4b7nSEyzQGvUC1HTzxT+cv/UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0kEZvRnR+9787ZHiZFT95tLOuks6WuOY1JnwcC07Ak=;
	b=pOVMsRfmRDagaPsuF9c20MLCTwB07zYcFCSJcFpF1O/C1pTFoOwDb5J87NNImYbIS/CjLV
	tTIoOsd3Rh+ThZDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove --unret dependency on --rethunk
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>
References:
 <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838916.14745.990733077781693826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     764d956145f21a0297004e9c67d7d60bde14e709
Gitweb:        https://git.kernel.org/tip/764d956145f21a0297004e9c67d7d60bde14e709
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:04 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:00 +01:00

objtool: Remove --unret dependency on --rethunk

With unret validation enabled and IBT/LTO disabled, objtool runs on TUs
with --rethunk and on vmlinux.o with --unret.  So this dependency isn't
valid as they don't always run on the same object.

This error never triggered before because --unret is always coupled with
--noinstr, so the first conditional in opts_valid() returns early due to
opts.noinstr being true.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 387d56a..c7275cf 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -151,11 +151,6 @@ static bool opts_valid(void)
 		return true;
 	}
 
-	if (opts.unret && !opts.rethunk) {
-		ERROR("--unret requires --rethunk");
-		return false;
-	}
-
 	if (opts.dump_orc)
 		return true;
 


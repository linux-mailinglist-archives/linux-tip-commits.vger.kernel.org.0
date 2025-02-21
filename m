Return-Path: <linux-tip-commits+bounces-3592-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD970A3FFB8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 20:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53731705C4A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA5252914;
	Fri, 21 Feb 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WI1kFbsu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xn0j8fDl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259202512F9;
	Fri, 21 Feb 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166199; cv=none; b=nvRi+r3xTKIc9d+vjCQRb07mlLN1nMFaREWc7J2oEg381ubbBvII924ajBGdaHKol1dZDhT57gX29avggNUkqbSQmS1E7r9Mf7a0fk+VVQ+csnjRQl5sgPCxhCHHHH+PL10Z/cptSLmMoIuPWkB/+87+ofparzEDZSi9t3a5Nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166199; c=relaxed/simple;
	bh=AMv+ZDLPp3B9fv+i1fT4EbJnQj5qCmCL6mIBOV6gWfI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NekVv6te575nY1v/T4ebbuaZx/oVzQD0zHnNVsYoZTCy34Cg778mA9ROSV48BMssVQoDp7eAEB+McImYa8NhJ2nFINPuxdj9hsqQkMm6Ie8mT3UubNuawqUBiogyIt2WtrhgyMEDJ6loRdr8Yd5qJru5IxpRx/sBH1o0IXZNKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WI1kFbsu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xn0j8fDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 19:29:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740166196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttacrFzN6P9zqrD/StE7kmyPBEQLn5yFpWSIEzaNx8s=;
	b=WI1kFbsugKV9DrI1IFhz3LukBT8F1SdWASt77doLUHPONK5NsqlJwVkcX53lcwQ1wUDnJW
	HZg7hyswyqeBnf5hUGmNzD1xtQjDOJSgmfV3K234N5uA2ULVIh7xMuKMUFbN/7P21ZylJj
	Pe6FquiBXki0z8IGPhD9RP9vwzSRwgXLU8nLV8h0Wi4V25E+OMrCu8pUkHLaZ1OfWZq30/
	ZoFme/6rgtqIu44EccAdnq020OqOBjgnX2EDHgD96dHUlg7GtuNGuaFSmdZ5hJJ3A0DWfd
	5sitVq2EgaNbjAmQsReclKfbiJljExTSAAf/rhHFOHvef2PIC7ALnvhgaMd05A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740166196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttacrFzN6P9zqrD/StE7kmyPBEQLn5yFpWSIEzaNx8s=;
	b=xn0j8fDlxpS1uJ4hCrjbHKo/EJtWJ7NdwHiBQq7iHNd68hs34+PJ61qB7brldHst+zLqsT
	UYw7Ps0j2gziDaBg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Remove duplicate included header file stats.h
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219111756.3070-2-thorsten.blum@linux.dev>
References: <20250219111756.3070-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174016619593.10177.2674839198004511641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b796ea8489918efb34cef0972ec3771b4a7b6f9a
Gitweb:        https://git.kernel.org/tip/b796ea8489918efb34cef0972ec3771b4a7b6f9a
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Wed, 19 Feb 2025 12:17:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Feb 2025 20:19:13 +01:00

sched/core: Remove duplicate included header file stats.h

The header file stats.h is included twice. Remove the redundant include
and the following make includecheck warning:

  stats.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250219111756.3070-2-thorsten.blum@linux.dev
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90b..b00f884 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -91,7 +91,6 @@
 #include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
-#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"


Return-Path: <linux-tip-commits+bounces-1936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C439947ABA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA71C20358
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74611586C1;
	Mon,  5 Aug 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJg6SCve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2cVpVhe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E3156F37;
	Mon,  5 Aug 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858969; cv=none; b=SYkcfAa7+KgqdWJmhz0fwQfVxEuMen6CAao8RS3UO/0ln3GP70FZSte4Y276stTSakziC7TOm5h41HaGADBW+kS20wJgIg00yj/fV6DDYYkDXdrKrsTSrSWxAKK+H/FWwBzdssBM8O17u61i3xVgis6V3KU17YQX0qnPqVkJvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858969; c=relaxed/simple;
	bh=+wCtWnnP41+WxKExhzv4193W3JBWQuOG7vdmu/ZLYuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YE7wnZgyLLcwRjN1HuSMRk8OMPbrZy8QYUZF7W6FXV8pqGNSquDSWQiyuTEj13X9Q81WGUFRMRaW/vL3qzvATtugbs+E2uSVwDsofxlXFUc+wF5BrIFonUC4IN0eeXuMkS0T2pl9eplO6Dy/M9dB3ihyyjflB77lQlYQiX95qJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJg6SCve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p2cVpVhe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWIdqzdgqQ+9ueDqpdFWYNod8pfMekem4DnLMusGl9c=;
	b=dJg6SCveh3TwUxczpui4Q0bMdXYd/M5rsYCgjChkmPhsPYPIp4WwUOaGb6nW+Zz5HqIlVN
	UKl7faObI7qx1DVHx1H90sKZSLTiXW0FUvU2V+OO1RKpnDFSMhE6BGVckQMCTxeLzMJ4qV
	gCxkabNXdGnkvVNJ1pYIIZlylt8EbueUTpHRL7oHRDBxbA3mXa78nA02wRR5YLB4JUbFDP
	tao9A7qrVDljdWMKLTHeEMQJXq6jeekbCx7Z8tUfr71iSo00H/RUbznh3hQF9eXKs+9kdM
	NbaCMCApYVyKw7WYMi/wc61zBofErGybjgYTWk0547TzHqMqU2coe0G/reQ/zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWIdqzdgqQ+9ueDqpdFWYNod8pfMekem4DnLMusGl9c=;
	b=p2cVpVheSuTAYa7nQDl4MQy/Ktql3Py00sc7gC4NqFDzKQuDJd6kawZrqBpYJfbX06UEWK
	FmAnCdf6xhOPkzBQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftests/bpf: fix uprobe.path leak in bpf_testmod
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801132724.GA8791@redhat.com>
References: <20240801132724.GA8791@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896446.2215.15536082593678175743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     db61e6a4eee5a7884b2cafeaf407895f253bbaa7
Gitweb:        https://git.kernel.org/tip/db61e6a4eee5a7884b2cafeaf407895f253bbaa7
Author:        Jiri Olsa <olsajiri@gmail.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:31 +02:00

selftests/bpf: fix uprobe.path leak in bpf_testmod

testmod_unregister_uprobe() forgets to path_put(&uprobe.path).

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240801132724.GA8791@redhat.com
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index fd28c11..72f565a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -477,6 +477,7 @@ static void testmod_unregister_uprobe(void)
 	if (uprobe.offset) {
 		uprobe_unregister(d_real_inode(uprobe.path.dentry),
 				  uprobe.offset, &uprobe.consumer);
+		path_put(&uprobe.path);
 		uprobe.offset = 0;
 	}
 


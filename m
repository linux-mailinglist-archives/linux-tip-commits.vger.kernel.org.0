Return-Path: <linux-tip-commits+bounces-4277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184C8A64AD5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C43B0B78
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9721F237179;
	Mon, 17 Mar 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFcA4xTF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsoTlTS+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711C2356C0;
	Mon, 17 Mar 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208392; cv=none; b=LVSLk1sl2IjAeYHHvF73KR21qG/kN9pcibEFgFrLK2iMgW+BXsmKDC7wM/HR+z4NhtlI6TaKi2Ttd3M30eS3Mci3cJ9oMFDED0ALpKSxOT7xQ9NIO4Gz8pGlKqecoY4VDcwi+qW8DXj0qyEwKHHA2afqPkFSYIzlPDgunW/ydGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208392; c=relaxed/simple;
	bh=SwBvWyV/VG6aZZ2NepGXNRDSJ6yT0V7lAW2+TP/yq70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I5BuGDHf7cLz6KwOIaJMRaXyeTd6WxZjQmU+f0s34/8iMV3WrQGX2mOFNYkGhTzEKGJAO4FB6r3x+aIvfN7kqE/KV7rrTw48qggG/4oLrKdeas9nROWGt2fJyT/SPFu4bYQBWICUmELjWK2TFunsMVHoQ4r/8v3GlW6EtfPBLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mFcA4xTF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsoTlTS+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGIpnDkoZLbGeqNs1lOYSnEAvAXKdjn3AxFCDuL1+t0=;
	b=mFcA4xTFXpUBxERitGTWmzguORSTvx/iYpnmHMxeE/uFPy4/5hzBUaRSe+aT1omsj9s/Zi
	vUQrwJkQ6EVpK78dUjDbPlojBtw+Fpx67jb6EgPES6LeqPRzFCMkVG33dUJcAM3q9tw6/m
	RxbbYeMxu9NZfv07Z8qHQ2qJj96WqB6yvEClphm3MF+fQEi0ukBoWk6bf0+JzeCPLcN5d+
	6dBW2ww5fGe7gLB2rYlVIa3osWzjC/XJHochkfm6Q8j5MjMC8Wgtu7kEXqLyk5UKlLlxD/
	9ggxhkLN4zS0xxqR/tOeeplESA7OmiPApx6F4v1uYM6aagZW4GUMP1X7/2Mm9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGIpnDkoZLbGeqNs1lOYSnEAvAXKdjn3AxFCDuL1+t0=;
	b=lsoTlTS+RPirmPWmNFZo+e6zP74tFxBRyi+nG14nmO+hQ572+9bYu1mo8Bq3jp30zwNVS1
	gmT4FBdfKNSg8XBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Consolidate option validation
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>
References:
 <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838864.14745.15903793682579487154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     acc8c6a798a011a5fe37b455b0286a85a4164b47
Gitweb:        https://git.kernel.org/tip/acc8c6a798a011a5fe37b455b0286a85a4164b47
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:01 +01:00

objtool: Consolidate option validation

The option validations are a bit scattered, consolidate them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c | 68 ++++++++++++----------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c7275cf..36d81a4 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -131,6 +131,26 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
+	if (opts.mnop && !opts.mcount) {
+		ERROR("--mnop requires --mcount");
+		return false;
+	}
+
+	if (opts.noinstr && !opts.link) {
+		ERROR("--noinstr requires --link");
+		return false;
+	}
+
+	if (opts.ibt && !opts.link) {
+		ERROR("--ibt requires --link");
+		return false;
+	}
+
+	if (opts.unret && !opts.link) {
+		ERROR("--unret requires --link");
+		return false;
+	}
+
 	if (opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
@@ -158,45 +178,6 @@ static bool opts_valid(void)
 	return false;
 }
 
-static bool mnop_opts_valid(void)
-{
-	if (opts.mnop && !opts.mcount) {
-		ERROR("--mnop requires --mcount");
-		return false;
-	}
-
-	return true;
-}
-
-static bool link_opts_valid(struct objtool_file *file)
-{
-	if (opts.link)
-		return true;
-
-	if (has_multiple_files(file->elf)) {
-		ERROR("Linked object detected, forcing --link");
-		opts.link = true;
-		return true;
-	}
-
-	if (opts.noinstr) {
-		ERROR("--noinstr requires --link");
-		return false;
-	}
-
-	if (opts.ibt) {
-		ERROR("--ibt requires --link");
-		return false;
-	}
-
-	if (opts.unret) {
-		ERROR("--unret requires --link");
-		return false;
-	}
-
-	return true;
-}
-
 int objtool_run(int argc, const char **argv)
 {
 	const char *objname;
@@ -216,11 +197,10 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
-	if (!mnop_opts_valid())
-		return 1;
-
-	if (!link_opts_valid(file))
-		return 1;
+	if (!opts.link && has_multiple_files(file->elf)) {
+		ERROR("Linked object detected, forcing --link");
+		opts.link = true;
+	}
 
 	ret = check(file);
 	if (ret)


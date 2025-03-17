Return-Path: <linux-tip-commits+bounces-4274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDBA64AAB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F6F1882D58
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41692356B7;
	Mon, 17 Mar 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mAzSOkai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sir22bHb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270E1C6FF0;
	Mon, 17 Mar 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208390; cv=none; b=U/ddFUNoOvPXWMIyV51Xf9nBCFOpp0UvTOKmCT4cRs7SveJP4oizjuloXc6+Ud6OlnmS9jrqHK8OUidOSRoMLtZN9Cx6tKGSW4+C/0eJpULhmLUL/yec0F+MHLdj3Qzq3ana7t6UJu+C2cF1Z9YzpqdyqUQYy0dEAat02NfnEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208390; c=relaxed/simple;
	bh=XkP11VNwHTgkdGlWwghWYeRz4rWuX4Q/A1NzlshIejk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b0Mdonk/2quRl97+3dsfURT9ttx5cuw5R1O25mURKPEbtQK1auBrzs4rKzIFrVZM2qOz7ICITMWTRF9Z5KVEo/sBiW162DBGVg+8AChcdl00jilZi8r1Mo402JJSJwa/PJFJuYYIqr1n6Iq+IllD8VUPcvZugqG99dyfMJCzXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mAzSOkai; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sir22bHb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFV817s1DrqJi1B3I1mhj9fp1LrXP5VRBmVLvDcGstw=;
	b=mAzSOkaiJ2Eu9LYgyJxuNNVYt/N44P89e8THBftZABP/b7G6m2bfYOXLU0atsusWZDHhZD
	KbB+Glacd9iybYyFCxuznW5gsuJ4dMmJqsTquxOg7wZVRkbYU0c/SUGu6BQeNIn4w0AVfY
	VX76bB2j20g8oy58jcv/DIqvr3s78bSeXi9WHy2UBt1tC+yGDE2FK2gi7QuTyyLedgYELz
	MhaG9vLLPxt60yBn/JwGG8w2oWrBGKzDTugaTYf1kwRGEKucOzLgSc6e9r80wA4zJtGAiA
	qguC+241mcXxdpRCcGLA298yGQyDycQMH5fJMl5SJ5Ucm5X1ZQxODTPsLbh4qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFV817s1DrqJi1B3I1mhj9fp1LrXP5VRBmVLvDcGstw=;
	b=Sir22bHbytiVMm0xoNmcDEWubVWxl3o7K6juZIsQ0tmmEE6wgQ092SIVbLWUPFbi69/I1j
	qYuNL4AwbJnUXPBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add --Werror option
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e423ea4ec297f510a108aa6c78b52b9fe30fa8c1.1741975349.git.jpoimboe@kernel.org>
References:
 <e423ea4ec297f510a108aa6c78b52b9fe30fa8c1.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838660.14745.18350712636141675850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bb62243943dbef4592266e817f4e2e5a96293907
Gitweb:        https://git.kernel.org/tip/bb62243943dbef4592266e817f4e2e5a96293907
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:01 +01:00

objtool: Add --Werror option

Any objtool warning has the potential of reflecting (or triggering) a
major bug in the kernel or compiler which could result in crashing the
kernel or breaking the livepatch consistency model.

In preparation for failing the build on objtool errors/warnings, add a
new --Werror option.

[ jpoimboe: commit log, comments, error out on fatal errors too ]

Co-developed-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/e423ea4ec297f510a108aa6c78b52b9fe30fa8c1.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c           |  1 +
 tools/objtool/check.c                   | 15 ++++++++++++---
 tools/objtool/include/objtool/builtin.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 3de3afa..c201650 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -101,6 +101,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
+	OPT_BOOLEAN(0,   "Werror", &opts.werror, "return error on warnings"),
 
 	OPT_END(),
 };
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2f64e46..48d7bc5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4756,9 +4756,18 @@ int check(struct objtool_file *file)
 
 out:
 	/*
-	 *  For now, don't fail the kernel build on fatal warnings.  These
-	 *  errors are still fairly common due to the growing matrix of
-	 *  supported toolchains and their recent pace of change.
+	 * CONFIG_OBJTOOL_WERROR upgrades all warnings (and errors) to actual
+	 * errors.
+	 *
+	 * Note that even "fatal" type errors don't actually return an error
+	 * without CONFIG_OBJTOOL_WERROR.  That probably needs improved at some
+	 * point.
 	 */
+	if (opts.werror && (ret || warnings)) {
+		if (warnings)
+			WARN("%d warning(s) upgraded to errors", warnings);
+		return 1;
+	}
+
 	return 0;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 25cfa01..b18f114 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -39,6 +39,7 @@ struct opts {
 	bool sec_address;
 	bool stats;
 	bool verbose;
+	bool werror;
 };
 
 extern struct opts opts;


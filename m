Return-Path: <linux-tip-commits+bounces-4282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45074A64AE8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8693A28FD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AB239587;
	Mon, 17 Mar 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/Nzk3c1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4L0ev44"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463D233717;
	Mon, 17 Mar 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208395; cv=none; b=OrWZC7Yz2NNx8xycZe9p8xqKWvPMaQEmR4uUvVfELjnTB8yLfTfGIgjvJ8MiPIDhB88O+xK2vCEZma20SVYivRbhtSBuYi+oQV3StDcHjBu078V2YdCt4d2x8q6F8RAkGYE5C6KVr+XWw0/9mhdYnUSW6dJrpwU7WqRQd4ZXP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208395; c=relaxed/simple;
	bh=9C1eqZHXOa3XdK0XzbjuzIJpP+O7L5ljHV6xk39AxvQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pl3wrbTlEDtzLEcO7lYwMHUOb68ihUpUy9n36kQc43Us11fAmE1Mzd+EPnQoT4OIGMrskeYOPiu5t8SRt08y1kIQfNLrhc+Igu9/uw+mVI7mXLKy2yaU2369eSYA/mZuK91WkUrzqzwMmOOMlYe+SxIoylqLCQO1FMHf2B+DkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/Nzk3c1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4L0ev44; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHQnhKj7/SkaipXJjhLm+Q2TlazierJFtcxv1jyAzjc=;
	b=B/Nzk3c1KW4b84xDx8fJfwlXixF3AiHhM37rU8bSIzl5/znaQWL0N50Rhr0Dq9C2ZNJuyC
	2j6Hd2cao7wIkPAvOULaO1nXJjYlMFotuifSqmxUAwUqyQnGo3AI5N0KtdCMgXsuija5JE
	LmxrA10ixJGkZxIFM71F/yaTSCv4/VJObsA/Q3mk/xFAd2U1J4wopi5u/EpFjnFMcPiO5d
	KnxvsjFULRyuX0GsIk+cf0+hurf2w5KdE8kwjQifmGEOwIxPFltE9dVRb3BwnJxjNgW1JH
	/bhPCMZlr472JwP1Pm0EfeFzHmCJoPMdL8TfhlopNLZMMXYtC149s5ga77HCbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHQnhKj7/SkaipXJjhLm+Q2TlazierJFtcxv1jyAzjc=;
	b=d4L0ev44wDd61C1t9PC6iAEXKo9tw9M7Ny4DA1SXFh1phCcke5VenHuopf1E+NlgEMX8Gp
	WWgytyLydMFzHKDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Fix error handling inconsistencies in check()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>
References:
 <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220839194.14745.12721604369366153670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b745962cb97569aad026806bb0740663cf813147
Gitweb:        https://git.kernel.org/tip/b745962cb97569aad026806bb0740663cf813147
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:35:59 +01:00

objtool: Fix error handling inconsistencies in check()

Make sure all fatal errors are funneled through the 'out' label with a
negative ret.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 12bf6c1..e68a89e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4605,8 +4605,10 @@ int check(struct objtool_file *file)
 	init_cfi_state(&force_undefined_cfi);
 	force_undefined_cfi.force_undefined = true;
 
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
+		ret = -1;
 		goto out;
+	}
 
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
@@ -4623,7 +4625,7 @@ int check(struct objtool_file *file)
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4659,7 +4661,7 @@ int check(struct objtool_file *file)
 		 */
 		ret = validate_unrets(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4722,7 +4724,7 @@ int check(struct objtool_file *file)
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 


Return-Path: <linux-tip-commits+bounces-7449-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E296CC784A2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A61242D764
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADB346790;
	Fri, 21 Nov 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BI90AWDW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yE3DbZvT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC755345CB9;
	Fri, 21 Nov 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719081; cv=none; b=ODi1+Es8J9OED7YpZ8lH99gOzLmDgiGYryoQqEEwyWrKnqqvzNp1lRDrP3h2AW/XbfSC8XCRBCS35kiliQy91HcgIlSrerwRLUDAXCBjYQuNdfQ7uHpYPy7SYK/q5JKj/QtdKl0UA8Aj4xJCrNQif7oknRganQ64SRMjcVVU9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719081; c=relaxed/simple;
	bh=QTtKQ8DB9ho/keMKcIR2tMi8k8k/OasjEGyMv4OzeS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dBsLbQWjxC8YshwdDbi9uatpmU+LgfmEeZAuoavExnFriR3MBHKra4TTmWESVlHfcalyE+3USjzBaEmNZqmUV2P0ErNW3XhdfkTMqDwPCUHgDc1sTBU9Dp7qdizPOO842511TFoyUzsRdnI6km693/XtpzxZeo95C1ZGBKj33Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BI90AWDW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yE3DbZvT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA+LI/exNurLacbJgd4Ozm+IZKZuB+AtGCdwiWJQ2kE=;
	b=BI90AWDWCbvKFFNzNFA27pSyoJJhvJ7KjM4N7M1LCL6AJe+cvvsR/eUM0rhYYZEJSSsOm9
	4oEUaCF8QZwJ0iV6G8ysPGSCqHJkXAvDzsj0LHP7lLmJXvOKYIAmoUlXn7qgV8+4P0iAiK
	6nP62W88vmW9QE87lycAZF0xVFBvTvEH6YosgtM9USz1M0cbi34hBsHDkU4pYMqXHdsw/3
	8eyIsL+3ckiLpHMFWtU8fNoJGdvk4/EReg8gLOalSb+b2W7EvynRyds0ICXyEOrKcRajJe
	9NWSLt7vsUilGWJGUMU+oEp78MC5FQ6CdslapW8U+2M6AAyxSRstbhwkqgx/AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA+LI/exNurLacbJgd4Ozm+IZKZuB+AtGCdwiWJQ2kE=;
	b=yE3DbZvTrphTBUWbCZUFgIXTUtq7SE5+4VPnLcUldI4CUO+3ioKI5/Tj7bnlcT3fW7R6qp
	LtfuFlbIfhWLbLBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Skip non-canonical aliased symbols in
 add_jump_table_alts()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <169aa17564b9aadb74897945ea74ac2eb70c5b13.1763671318.git.jpoimboe@kernel.org>
References:
 <169aa17564b9aadb74897945ea74ac2eb70c5b13.1763671318.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907682.498.10003398796469998322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a91a61b290430ba0dd2c42378f744d6b21657f42
Gitweb:        https://git.kernel.org/tip/a91a61b290430ba0dd2c42378f744d6b216=
57f42
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:52:19 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:08 +01:00

objtool: Skip non-canonical aliased symbols in add_jump_table_alts()

If a symbol has aliases, make add_jump_table_alts() skip the
non-canonical ones to avoid any surprises.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/169aa17564b9aadb74897945ea74ac2eb70c5b13.17636=
71318.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 72c7f6f..6a4a29f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2197,7 +2197,7 @@ static int add_jump_table_alts(struct objtool_file *fil=
e)
 		return 0;
=20
 	for_each_sym(file->elf, func) {
-		if (!is_func_sym(func))
+		if (!is_func_sym(func) || func->alias !=3D func)
 			continue;
=20
 		mark_func_jump_tables(file, func);


Return-Path: <linux-tip-commits+bounces-4580-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB06CA74C06
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 15:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4355D3AD791
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BD1632DF;
	Fri, 28 Mar 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ViO3omp9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWY29ugO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5E22F19;
	Fri, 28 Mar 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170391; cv=none; b=Nc0LrtA77G1iRBHr5nh+ceiKD+Jd91kJOdONV9lKzbMlEPtsGQs+wUhKKHMibgYr/T4gGersWHe5B8eC25crfrOf0fY1G0aWwfx/x36EK7EDHEMv2tqguA03BSM5tqIlZoT3yEDv7kT4yhQtuwlJTqNn7b8QYg3j3HQxZCoAW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170391; c=relaxed/simple;
	bh=RczSzSmvulrn04mNu0llNkgHtRN1wJlAc3a9Y0Nc0sE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AqSQNuhSXEL1QYTfGpxq7f58k3VXOcUo+pi3uh1BOdbK94dzxEStlNWECZtBK7qymAuyAo25iqKhvuUfEGxZSqavbtG2px4RNi/QpLy2whvy3rmgTcq2zFp8BptnapJmrykfPpCuRdM6YllZ05aZLUTur8RMhO7htdoxx5JefG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ViO3omp9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWY29ugO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 13:59:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743170388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A+77kVfeVvx+iqMGlNZUBZQVAyC3nZbvHUb8ZSYIxg=;
	b=ViO3omp9kKpS1CG6ScM2y/XJusZBCHPa7t3OeqdolAT4AnTQDf3b4TgxVEhdcAlQ7y9wcH
	al2vxfdxYqGBXctQL1676eKM31dFAO4E60dBjvSJ39R4zWJ/xPQ3tUiHmk+ftVilBrMxIR
	1h+YTXn4slkfx6zdMwajyIKoVYKEeiOZx7D955nP/nZM4UG5dkjL+QdSfQQrF1yLGolqYU
	Vvnc1LovcXriiw564CJjZ0/XGpCcCrCfZ9b8EW8+xJKLLA8z0ZUqk6yYBwn/9YdapXxVIT
	jJ88Xv/XD6oFPsiPqb9FrVpEbgEdBELWKYroJEpEx/FQgGriAuR05vcP+5poSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743170388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A+77kVfeVvx+iqMGlNZUBZQVAyC3nZbvHUb8ZSYIxg=;
	b=CWY29ugOBKDFz3Gjrz2c44onExJYe3fpzk2lgIIJv+A88FptxeurzYIqAqjD3eF48EMIrC
	u5QX45nVfFk5i1BQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix STACK_FRAME_NON_STANDARD for cold
 subfunctions
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <70a09ec0b0704398b2bbfb3153ce3d7cb8a381be.1743136205.git.jpoimboe@kernel.org>
References:
 <70a09ec0b0704398b2bbfb3153ce3d7cb8a381be.1743136205.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174317038703.14745.9272101029964137349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     b5e2cc57f551a1a1e2c0ea36f77c1e26d3d13c35
Gitweb:        https://git.kernel.org/tip/b5e2cc57f551a1a1e2c0ea36f77c1e26d3d13c35
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 27 Mar 2025 22:04:22 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 14:47:02 +01:00

objtool: Fix STACK_FRAME_NON_STANDARD for cold subfunctions

The recent STACK_FRAME_NON_STANDARD refactoring forgot about .cold
subfunctions.  They must also be ignored.

Fixes the following warning:

  drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool: vmw_recv_msg.cold+0x0: unreachable instruction

Fixes: c84301d706c5 ("objtool: Ignore entire functions rather than instructions")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/70a09ec0b0704398b2bbfb3153ce3d7cb8a381be.1743136205.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 29de170..fff9d7a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1014,6 +1014,8 @@ static int add_ignores(struct objtool_file *file)
 		}
 
 		func->ignore = true;
+		if (func->cfunc)
+			func->cfunc->ignore = true;
 	}
 
 	return 0;


Return-Path: <linux-tip-commits+bounces-4600-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E09A774FC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611DC168C53
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA91E98FA;
	Tue,  1 Apr 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZYru2tF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EA5qfOaM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD11C3BEE;
	Tue,  1 Apr 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491721; cv=none; b=Mmb15OFmRQ4sZvyvZutTFJe/AgRAFdr2CGj0Uv9rliVlnRaLryOJVYxugMVet0nNhmiVwurI6ViVLH5/jIUn9B2YxduKY96IzeUPxYwRlO5uDUXENqge1qaORH92ryfy+d0GhoVIFJLfQg0Lfv7lhc3ovxsziPjFgUi4maNdIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491721; c=relaxed/simple;
	bh=NaVq7T5DmQjSEXSqCGXJ8Chfgy+8jpXv+92rtMXTAuc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XmHNRpR2ojvoP4e+wLy6TZ2zokwSdR2651d43Tfj7nQCadFqC9iUEA1yO07pQ/Bs1nk/G84nFyrEbqaJ0wbVDIEOKbqRnITceMeI+CodHDebqvQIMqvPoKH7XnOo0d00miU1phPq6wPS5oqK6WNBKUwG/CngrYYHovL6XF/O2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZYru2tF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EA5qfOaM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69fIK0yHvgU+HXvgqzW1IA6EniJRCfM0IuI6vt0Degg=;
	b=zZYru2tFpaOJRsdcRC4uA30pgmvnD60tnHVqzDpkB2tZVsgvHiCfOhhuAAJOiqZCWO2l56
	DNIa2CZQnTVvbKAbgoBg5C1nwKE7yJycyNsKNvOdpXc8V0VKbI/xpBuDho9ma2a40aexDC
	xgMjTcFRK/I+TJOO1cZigTYfcnKe+LkjIgY4efxnOLAKYl8TbvIbGjYMwhf7wGCaHv8nhs
	ALEMzpiFflH9lLHdNnBeKTrgaOVowd+qbHxPZn0qTg+6tDeQlNDGjja8ct7jXFE97TyzE3
	L8a7MmsQaqj0IJugFbYS9cZZoo6rsSLHIL1ZNbXIhChrl4R5nBvK63lTN/uWsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69fIK0yHvgU+HXvgqzW1IA6EniJRCfM0IuI6vt0Degg=;
	b=EA5qfOaM6Ix4TseDboXiZdxHttkSr1jS4vMXu+xImUvckT8pdFWTYVYPPYUHGQY3bS4IWZ
	RemhIUunUeOuMODA==
From: "tip-bot2 for David Laight" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix verbose disassembly if
 CROSS_COMPILE isn't set
Cc: David Laight <david.laight.linux@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <b931a4786bc0127aa4c94e8b35ed617dcbd3d3da.1743481539.git.jpoimboe@kernel.org>
References:
 <b931a4786bc0127aa4c94e8b35ed617dcbd3d3da.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349171719.14745.7357908740148554493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     e77956e4e5c11218e60a1fe8cdbccd02476f2e56
Gitweb:        https://git.kernel.org/tip/e77956e4e5c11218e60a1fe8cdbccd02476f2e56
Author:        David Laight <david.laight.linux@gmail.com>
AuthorDate:    Mon, 31 Mar 2025 21:26:42 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:13 +02:00

objtool: Fix verbose disassembly if CROSS_COMPILE isn't set

In verbose mode, when printing the disassembly of affected functions, if
CROSS_COMPILE isn't set, the objdump command string gets prefixed with
"(null)".

Somehow this worked before.  Maybe some versions of glibc return an
empty string instead of NULL.  Fix it regardless.

[ jpoimboe: Rewrite commit log. ]

Fixes: ca653464dd097 ("objtool: Add verbose option for disassembling affected functions")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250215142321.14081-1-david.laight.linux@gmail.com
Link: https://lore.kernel.org/r/b931a4786bc0127aa4c94e8b35ed617dcbd3d3da.1743481539.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ff83be1..4a1f6c3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4523,6 +4523,8 @@ static void disas_funcs(const char *funcs)
 	char *cmd;
 
 	cross_compile = getenv("CROSS_COMPILE");
+	if (!cross_compile)
+		cross_compile = "";
 
 	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
 			"BEGIN { split(_funcs, funcs); }"


Return-Path: <linux-tip-commits+bounces-4577-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF00A74BC9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5936D169D2B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85718309C;
	Fri, 28 Mar 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WsP1ARtf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/rpX2Hz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76B17A311;
	Fri, 28 Mar 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169709; cv=none; b=cgFg5Q+LGoRsIEHu1aNvg7ZAavUxrrfBjMqwRia1ua1By/aycOqEiHqymyQQSlxHTKlffa+fUkeyvSqydi9wlc2G7Hu/HqA3CrR87iaa9fGSm4J62dGTXH6ufFafX5DMnGaWPNMfb/9qITmLRYtfK9Gxhm0rU041CP4pQxSaakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169709; c=relaxed/simple;
	bh=AQnc0q6XPBSWqp3ObnEGEfmqwiJpfcrXlUDsqPnb9sk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zu4kS3cTkonx2LWHf+XHRX1miXdFPst0zipCT+4E7YKA1EMYrU3ExLfEYupj+c2WCyQ+ixXO3CSTT8j/FvLvqZFEh0QgzEXZBtNQIM1AqPTuRELUb7rN17zXwPb6Nml5w0LTtdsgMKV/vVTCruBQQV1osYzKrMXFvMt8IOXNYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WsP1ARtf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/rpX2Hz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 13:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743169705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UR2qqIKg0l9BB5UIDzBKYJaEc6hDV4BtIEufdljkeaY=;
	b=WsP1ARtf7A+IVepz+zq/47k7ydcbbjlNXnSIy3Dy5YLVjVDNA4+PRrNK30tp8KRHjayRh1
	D61WCrLNOEmW/sAZO/vZDkxsv6mdm3+ttktKNm9MujrRcNlpgGU1ZSuIoytt/cNOMfNQRo
	XS5H4YfkVn6gIN7TBGlPeg40D8gASDQ/owzeRVcGtY9ss4lWzcjYy4w7W+bMGuCg0H1lK0
	zNZC79SDla1fu/SiA6zQUJZYsGvv4V4hVC2MDwRdxAX3BKNuOdJ0+2cY5ZeNKIeC6GeYuC
	VmVE7e49Q94SIsz7mHHH0zJA5lVSQcqTkiCiDJk7ylpB7tqJMtMugqvgsqgkcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743169705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UR2qqIKg0l9BB5UIDzBKYJaEc6hDV4BtIEufdljkeaY=;
	b=Z/rpX2HzSXkdYX9si0yrMsz2tFMrvMGWT1MGM0KN7AboC+iNq7SwWD+AhnCyWZ4iLfwOWD
	LrIYQw1CqFnrc6Ag==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix NULL printf() '%s' argument in
 builtin-check.c:save_argv()
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
References:
 <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174316970081.14745.12219421049589784447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     d9a595c3850ea4383628115df2bb533af3b29f4f
Gitweb:        https://git.kernel.org/tip/d9a595c3850ea4383628115df2bb533af3b29f4f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 25 Mar 2025 18:30:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 14:38:09 +01:00

objtool: Fix NULL printf() '%s' argument in builtin-check.c:save_argv()

It's probably not the best idea to pass a string pointer to printf()
right after confirming said pointer is NULL.  Fix the typo and use
argv[i] instead.

Fixes: c5995abe1547 ("objtool: Improve error handling")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/20250326103854.309e3c60@canb.auug.org.au
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 2bdff91..e364ab6 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -238,7 +238,7 @@ static void save_argv(int argc, const char **argv)
 	for (int i = 0; i < argc; i++) {
 		orig_argv[i] = strdup(argv[i]);
 		if (!orig_argv[i]) {
-			WARN_GLIBC("strdup(%s)", orig_argv[i]);
+			WARN_GLIBC("strdup(%s)", argv[i]);
 			exit(1);
 		}
 	};


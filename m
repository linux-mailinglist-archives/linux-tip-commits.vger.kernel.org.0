Return-Path: <linux-tip-commits+bounces-4569-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2058BA72E6D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B4F3B4624
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38F20FA91;
	Thu, 27 Mar 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bemV1THL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEO7oxuA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518551FFC46;
	Thu, 27 Mar 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073571; cv=none; b=ZBJ740I8QBd6hdqRM1SR0RocC9BvUGOfhZqgpBPyVPSHsJ3Zlt52x7gr1r7R/qYfmM2SoAthHbXyyT+AZ7sxJoEjP0rBmV+bCZTwcXgpNTfj2AxhmiXJxrI6P3TIGX4tKB38TQXE0YynVayOuQhWveCk6bYqBNqHc2BWQibXGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073571; c=relaxed/simple;
	bh=cqnyQ+vW0sB9tC0RhhmQWZ1jjtAE3NVGfyJDh+yfk4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uQtkDYh4PH8opY2COo4gTcsHZfn7JQHX+ayBkkGmjwaDFu193aohTKr+bKr8S749+p97ieTHtMO4cJYHJceUdf+NCbZxWC7XLhtwpMSMOwmXRy1Rouqf54arzNneXAtGQ7I+aycX91k2cOBMNIMJsVlHwEULr+6DbhAfpAATQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bemV1THL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEO7oxuA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Mar 2025 11:06:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743073567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmnuIpNPezLe8uqXaAsoG3r9n3+ABNkH0p20uvjPuNs=;
	b=bemV1THLy/j3EPXTuXQRUjbxVNdMVErzZSyMpe31uDboian0lSMulheFQkYqyyWnYMkDj7
	lY8viqnQF1kuxdrICjiiYwRhliBG/g7yoTdS/048Tlvlg1pEqT0BPRbZlbDXdo206dM5ZY
	2PWIgwOTN4QPhfGsCB+2azBLW3ky+vudMQkqSaGT0LTD+eSxgNzCHuAGMlMORb3HskO1rE
	jEBPc5nVvtVz/NO6eWDLfAOJqnVuHz0LQpv/ZA0y3heHu4f3dEEF2ul2N7/Cz3R5WbkDsZ
	nL6Aszbx6F3PLjk0lMjX5vGfT28wzrUUEISTeXODPYU2YtU1gTJKoMgAfcuDQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743073567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmnuIpNPezLe8uqXaAsoG3r9n3+ABNkH0p20uvjPuNs=;
	b=VEO7oxuAwvvrnY5tucX48Vpsf3nnnzLoGDIpcPPIofRhzuLfdS1IanwGzDwKQM7by75/bq
	JY6wJnTz4lp4iFBA==
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
Message-ID: <174307356146.14745.376160712541031348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     1c9d28fdf70d4ae3e8dfeadee982461403c6bb50
Gitweb:        https://git.kernel.org/tip/1c9d28fdf70d4ae3e8dfeadee982461403c6bb50
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 25 Mar 2025 18:30:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Mar 2025 11:59:11 +01:00

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


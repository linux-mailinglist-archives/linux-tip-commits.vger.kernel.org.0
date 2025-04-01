Return-Path: <linux-tip-commits+bounces-4604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2CA77505
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C761889F73
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEFD1EA7FE;
	Tue,  1 Apr 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4sITdfV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2NJAPg8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818E1E9B39;
	Tue,  1 Apr 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491724; cv=none; b=pnU9bAdJcw0LYcyhqMxcrSo1JQM2La57NoptwU6fZuR6d/vgL7f5qZizzj601+yV3xiRGj/GmaDwUyCL9tnpZi4bs8Um+fA6j9CWTMJAqbLl4rfJ4CFTFWX2MP+1XrQRlLRTkIeoPxYslkCzKPATnub7jk5lDrAPzTVbJ23htyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491724; c=relaxed/simple;
	bh=P5dQYIuj3rObuV8FLTmmCISsXq3DV9PJKocLQ6gRJHY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R/84FCze7poEnttH7vzI047ATlQDuXwOP7ShyvSlht4LNPL0c3IbGOfAMtbyfSrMinqRROk49/6VPLg05UVCD7Zns2U2DBQn4+DEvUtBfOdBkTK/0aKBsV8rSx4KxF7rO2QxZMOEd47KFCd1QSRH9FTOPKbkUO6fze9QOoJXrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4sITdfV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2NJAPg8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuZZZlzpCr7e08pJx8nS2nggVSkSCwoNQu+UoKC1FU4=;
	b=Y4sITdfVvYP9a1l/6/f8cIzVUZxyddmVMCEmac02cNfoSJudh/1CzNqii2SizSayveVH0B
	nHJwpBZMxyw+6S2W+ZiKXuG2Q3pavWXQSKJMaVI2ItpMCZpDZta52ewTIU4zWm1jiXLxVO
	RPWqJg+lh5D/5FCjQFdTAqQf/1nlR5EpNdS45B2qftqAomKgVhcJQpoN4jCUjgkS5m6qZd
	ngdY/OZuUjyBEPidVbelYtj7nN6eH6fZRDpr7DEl//YbKdFEB7uojTG0P/yd+2ar6rw7zm
	NWhCivc8kv2bE/BAjFh2DnL9hQvkui4J8KM6FJl8BhKV7KT0kyleAJIAFJXukA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuZZZlzpCr7e08pJx8nS2nggVSkSCwoNQu+UoKC1FU4=;
	b=A2NJAPg8KibW2ULJYh8rqQepFmsJYcw2AAg86V/B+QnIGhH7lsqOkDR0UxDskGnWyDVCcD
	9Xho62dnOdVgi2Aw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Append "()" to function name in
 "unexpected end of section" warning
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <692e1e0d0b15a71bd35c6b4b87f3c75cd5a57358.1743481539.git.jpoimboe@kernel.org>
References:
 <692e1e0d0b15a71bd35c6b4b87f3c75cd5a57358.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349172053.14745.17990220429172466421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     188d90f817e13b66e03e110eb6f82e8f5f0d654b
Gitweb:        https://git.kernel.org/tip/188d90f817e13b66e03e110eb6f82e8f5f0d654b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:12 +02:00

objtool: Append "()" to function name in "unexpected end of section" warning

Append with "()" to clarify it's a function.

Before:

  vmlinux.o: warning: objtool: cdns_mrvl_xspi_setup_clock: unexpected end of section .text.cdns_mrvl_xspi_setup_clock

After:

  vmlinux.o: warning: objtool: cdns_mrvl_xspi_setup_clock(): unexpected end of section .text.cdns_mrvl_xspi_setup_clock

Fixes: c5995abe1547 ("objtool: Improve error handling")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/692e1e0d0b15a71bd35c6b4b87f3c75cd5a57358.1743481539.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e6c4eef..bd0c78b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3761,7 +3761,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 
 			WARN("%s%sunexpected end of section %s",
-			     func ? func->name : "", func ? ": " : "",
+			     func ? func->name : "", func ? "(): " : "",
 			     sec->name);
 			return 1;
 		}


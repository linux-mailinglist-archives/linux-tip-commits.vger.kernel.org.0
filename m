Return-Path: <linux-tip-commits+bounces-869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAAA8933AE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Mar 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92961F209A5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Mar 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290915099B;
	Sun, 31 Mar 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LoG92uf8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ih3gkHa"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7714F9F0;
	Sun, 31 Mar 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903163; cv=pass; b=HcjiBtfqJLyGUKDGIB5JlKm6lJt7yn0IrkBV7cnxi/wu3M97/ukqJMgJYXojJZQx+ocaFx3AYWshxC6QgwFgB4N92w2aRN/Sn3GMyiBiCUz2+HZe0IaNVj/QmYcrhufGMTYGx1233gh2Ij6JfFhQNZ2udJL270P8o0dvCr2AHHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903163; c=relaxed/simple;
	bh=kI2RgQKIy46E4/XMESMBolqMfp3inpi7STqcXxY3bTc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Y1rwwoFlekN2YagB6VPnSTlxauterLrgXa2fTNHlFDhiGQXN6CQnmASfRSPWhIiy0C4jWzwRCJ/RsfT6KE8hsXFZsZAiLgEjuIh/3TfZiIKkkk3y4k30IRdfyu23oRiXCz67o2KBhkGveind5Tcibe8veBhddECYV0exXJ9FGPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=fail smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LoG92uf8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ih3gkHa; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linutronix.de
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4A0F920847;
	Sun, 31 Mar 2024 18:39:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vHNF8mn3RxDu; Sun, 31 Mar 2024 18:39:19 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 78A94207D5;
	Sun, 31 Mar 2024 18:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 78A94207D5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6BC66800050;
	Sun, 31 Mar 2024 18:39:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:05 +0000
X-sender: <linux-kernel+bounces-125891-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAh2QFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 10123
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125891-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 0B65A2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LoG92uf8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ih3gkHa"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833791; cv=none; b=N60ZmogJcIrY2L6MU/GRXh8t0VDW9S1abCOo4sQlXFcD6zL8NQi4tuNRdBre1E0aZPSlGtcaHK/Dm/vagHxq1C1ZnVOJoBS79H4zJToADw/r0XmdLVxRdQH/3XF7SY2i60hEKYuX88gnJPfBg+SdUdNGTk/NfjscCJRY6BRN5GU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833791; c=relaxed/simple;
	bh=kI2RgQKIy46E4/XMESMBolqMfp3inpi7STqcXxY3bTc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NlPsmfyHkpTTQczfzqwZ5gghbr4Yfpvy1r9m1YwJ2VfZgh2tp/yLaSxgVolRrMwsyEA601cTAlpzXTjVCGO2T5zMSVjL01QzaeLkBRvAuGhRh5V+RoxSb52hwRuJSwqmfEGacFGdETjFydSlNgc/Ha7NTiFrQD6OLu8wSg+JP6s=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LoG92uf8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ih3gkHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 30 Mar 2024 21:23:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711833787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cO9DAoslNiaRo5wWS5uXMV/wBejmz6LP19eIIxQWH84=;
	b=LoG92uf8MRxCmeUIR8y99oipc+Ec0zFD01sBvcCvF4kvwqhzYticOJLJI2Imw1G5vJo48K
	Bhf+RiMe9EgjlzZmzkGKZ82tPKRa4isU0H5U59l7Aah0dn0cZjEbtzqXVjFssNM/ZS+gTX
	75e/I4LlhP+L2LPHGaQiQw0YW7UiJy293F51HKFjcxZPZVnTZl9+nygJ/8mnoElJP8/jRe
	krQzC0A9e5CCsisk6s9o87MvmiS5RwCmOnay9T8/ZhxXCRdIq9GI6UnWS/2ngoR740U/xp
	mDIfcTPjXqgRfw0MXOVBb5pnpGmIQ5GYU7ghBmVb9aLbof0ilhnTmtYYzfXUbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711833787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cO9DAoslNiaRo5wWS5uXMV/wBejmz6LP19eIIxQWH84=;
	b=7Ih3gkHaVxHnnSi5Qq66j9ZfM9NojoK8BpYL4FzLlJjZxysHt8r/Wxfv5+ofYJr/fZNw/e
	732gzNiSePILIuAw==
From: "tip-bot2 for Mikulas Patocka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix compile failure when using the x32
 compiler
Cc: Mikulas Patocka <mpatocka@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171183378642.10875.5605747277159898590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     6205125bd326ed0153e5f9da3c4689fe60ae885a
Gitweb:        https://git.kernel.org/tip/6205125bd326ed0153e5f9da3c4689fe60a=
e885a
Author:        Mikulas Patocka <mpatocka@redhat.com>
AuthorDate:    Sat, 30 Mar 2024 20:23:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 30 Mar 2024 22:12:37 +01:00

objtool: Fix compile failure when using the x32 compiler

When compiling the v6.9-rc1 kernel with the x32 compiler, the following
errors are reported. The reason is that we take an "unsigned long"
variable and print it using "PRIx64" format string.

	In file included from check.c:16:
	check.c: In function =E2=80=98add_dead_ends=E2=80=99:
	/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:46:17: error: fo=
rmat =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long unsig=
ned int=E2=80=99, but argument 5 has type =E2=80=98long unsigned int=E2=80=99=
 [-Werror=3Dformat=3D]
	   46 |                 "%s: warning: objtool: " format "\n",   \
	      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
	check.c:613:33: note: in expansion of macro =E2=80=98WARN=E2=80=99
	  613 |                                 WARN("can't find unreachable insn at=
 %s+0x%" PRIx64,
	      |                                 ^~~~
	...

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0b10ad0..0a33d91 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -585,7 +585,7 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
-	unsigned long offset;
+	uint64_t offset;
=20
 	/*
 	 * Check for manually annotated dead ends.



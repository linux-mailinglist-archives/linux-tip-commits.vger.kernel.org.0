Return-Path: <linux-tip-commits+bounces-6978-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF11BF5CE4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1664405E66
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C01990C7;
	Tue, 21 Oct 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2YwvmepR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+wV7QiU2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243432F1FCC;
	Tue, 21 Oct 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042952; cv=none; b=gPoxME2qX+rLrL9MbRaRX8DSdN+ughoQhlSafRW9vSsgNKd/0I6vcLeKjYybrtuvR9W90JbblSB2ProAl6jldjGWOBRLvu20vFaHB7zqMJaG9L6n/QfY09Jc8u5RtX+Hv0Fdhsz4syUcaob04YjTnqKYkKLUZAl3cQumtQPcXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042952; c=relaxed/simple;
	bh=tEhll25aflXfKr4KLnD+GKC3wBecWa1F1HmKLV3pxGA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SQnlVW4toSlHJq8JdKr5pCB6PAF+pJhdrzJ8ig8GJPAJ4QWB6sbrNfB3GbLXTYU+SlbrHv4fLGU8w2CgRTO/MY/mdr+LL8q1OCJxWMCCnILJbmSxHJpjo4virig6sLHIZrzjzQ7mle21dWUhAqMLg9PdWCpRdjzWYCw8oKgaKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2YwvmepR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+wV7QiU2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042947;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkLjn9BOxc3PrELdEWI/z+N3nzeGXqRyYuqnRbxVY6c=;
	b=2YwvmepR9ORRT7W/GYRq6cEYIKwNHE9HrkcAZDijvFGzLaaNRW/S5si1xYho4e3HQngrCz
	KN2hY2ft9RcAdr2J4jcQAs6Jz7jUnxF0Mjfa/zbemkrruVwPuwgHEXOtxlPK21BlvlXOyA
	rPck25bJSZUGbjOAmbq5W7YZZB/dO7H1wx3b5R3J+59oCxCD3rtgEjEESIDbUse0KVMQov
	KYluY0M/1fjmLuM3T7zRsMo4K5ET4UWEP2ayNrgBTl9lb9G+P4H96U/6I0Qd5ThAingqta
	2vTszBrWuAe9kb43SzngjYoJBWA1oxrxtOmgWHfa5gtQTtROe5dNJttXaNKPOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042947;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkLjn9BOxc3PrELdEWI/z+N3nzeGXqRyYuqnRbxVY6c=;
	b=+wV7QiU2w/N1w0COhC9vOYKZjORJVK3vuoAHa6um2AeJbj9+r4RIeTmWWzxUAiYytoliVk
	roi9FOHuSirOWLDA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Qualify RETBLEED_INTEL_MSG
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251003171936.155391-1-david.kaplan@amd.com>
References: <20251003171936.155391-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104294615.2601451.15528695828339283083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     204ced4108f5d38f6804968fd9543cc69c3f8da6
Gitweb:        https://git.kernel.org/tip/204ced4108f5d38f6804968fd9543cc69c3=
f8da6
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 03 Oct 2025 12:19:36 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Oct 2025 12:32:28 +02:00

x86/bugs: Qualify RETBLEED_INTEL_MSG

When retbleed mitigation is disabled, the kernel already prints an info
message that the system is vulnerable.  Recent code restructuring also
inadvertently led to RETBLEED_INTEL_MSG being printed as an error, which is
unnecessary as retbleed mitigation was already explicitly disabled (by config
option, cmdline, etc.).

Qualify this print statement so the warning is not printed unless an actual
retbleed mitigation was selected and is being disabled due to incompatibility
with spectre_v2.

Fixes: e3b78a7ad5ea ("x86/bugs: Restructure retbleed mitigation")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220624
Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251003171936.155391-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a526ae..e08de5b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1463,7 +1463,9 @@ static void __init retbleed_update_mitigation(void)
 			break;
 		default:
 			if (retbleed_mitigation !=3D RETBLEED_MITIGATION_STUFF) {
-				pr_err(RETBLEED_INTEL_MSG);
+				if (retbleed_mitigation !=3D RETBLEED_MITIGATION_NONE)
+					pr_err(RETBLEED_INTEL_MSG);
+
 				retbleed_mitigation =3D RETBLEED_MITIGATION_NONE;
 			}
 		}


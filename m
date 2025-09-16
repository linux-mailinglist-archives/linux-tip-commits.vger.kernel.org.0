Return-Path: <linux-tip-commits+bounces-6651-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA7B596AC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CEE1BC8416
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9321CC58;
	Tue, 16 Sep 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAilbZSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plcgIPtz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A741C71;
	Tue, 16 Sep 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027272; cv=none; b=KkiRiu4hL0tp2SDxyjNgzEsJhn9HzlotvD1+PAXiHgtrAm1l7/h9Bt/rePO58x/wV6JrhEU5HKNIajSVkYzlAKEGtXmg0Kquxsscs8qz3gN8zrZ2ovD9DeMAiuLsxvoJVgKtbcaNn4MIG3w0nywWf6gDsAEj9ufPvVqvN3YTEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027272; c=relaxed/simple;
	bh=U/8fdfaHcE82T/Uiw37pPdfECOQnI1BsTEGUwrPA6jk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KzJy2F5GD9doMyp2Sfhjzh1261XTvpZCkaFkuvGAXh+WLnriphsSHVQBGtx6KOjuxHGMsz5fG8oJFB3ID2x4DFmeSbutSFqd+jSGSxQ5kAi+jOK+LZjFKYoXFPZdCXet6SeFSjTbznmpaMmyrSLU+bunLN9OEuHBFGVJtA7qubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAilbZSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plcgIPtz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gntQDu2gJas8S0oXrRtrwkAfMIyqUOG5whS2SGa/GBM=;
	b=QAilbZSM8cow/OHWyFKH913MbASiByvTFtBmpd7YAFHmimudfOvfOfLtFViGxRyQsa16l9
	B3UOsodyiXt6L14l6o0+VpAqyx/PjwSIxWWbMh5RASEgGqCvMlNCq1LnqtIbynJG8vs40g
	z+IZkoDhM6rIj3gpzzUT67QvwfaGOjxGwQKDMVniAWMgsyuaMruZYjF+fklfMWCmfvAWCn
	yPSnaBp7xLlepAwp/+xbX2hq8OGwqx9I3xDZv8IIi+vTfxpDGtprapD0oHINB9XCV4CHLJ
	bQ72/PUT1ffHfYrNXfqEuC8xfF7IoYYSqxzG4RK7zIkycIfK2zzgUpE1KVeLbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gntQDu2gJas8S0oXrRtrwkAfMIyqUOG5whS2SGa/GBM=;
	b=plcgIPtzCtsB3Shk4ub2RnAPOMT2B1i64hB7W75WE3IKWGbKBKsWVKfxk3KcF6wHYilk4a
	BOleLCqh3Dbs4ZCg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Report correct retbleed mitigation status
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250915134706.3201818-8-david.kaplan@amd.com>
References: <20250915134706.3201818-8-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802726763.709179.8421464307764384653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     930f2361fe542a00de9ce6070b1b6edb976f1165
Gitweb:        https://git.kernel.org/tip/930f2361fe542a00de9ce6070b1b6edb976=
f1165
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:06 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 16 Sep 2025 13:32:18 +02:00

x86/bugs: Report correct retbleed mitigation status

On Intel CPUs, the default retbleed mitigation is IBRS/eIBRS but this
requires that a similar spectre_v2 mitigation is applied.  If the user
selects a different spectre_v2 mitigation (like spectre_v2=3Dretpoline) a
warning is printed but sysfs will still report 'Mitigation: IBRS' or
'Mitigation: Enhanced IBRS'.  This is incorrect because retbleed is not
mitigated, and IBRS is not actually set.

Fix this by choosing RETBLEED_MITIGATION_NONE in this scenario so the
kernel correctly reports the system as vulnerable to retbleed.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250915134706.3201818-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 66dbb3b..6a526ae 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1462,8 +1462,10 @@ static void __init retbleed_update_mitigation(void)
 			retbleed_mitigation =3D RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
-			if (retbleed_mitigation !=3D RETBLEED_MITIGATION_STUFF)
+			if (retbleed_mitigation !=3D RETBLEED_MITIGATION_STUFF) {
 				pr_err(RETBLEED_INTEL_MSG);
+				retbleed_mitigation =3D RETBLEED_MITIGATION_NONE;
+			}
 		}
 	}
=20


Return-Path: <linux-tip-commits+bounces-7863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFABDD0DCA0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52789302D6F5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B912E7623;
	Sat, 10 Jan 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugWTmEP0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ci6ImHMQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7652DCBE3;
	Sat, 10 Jan 2026 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074394; cv=none; b=M+eDf/0u7oJO8JbALlBMXO/Ke0PMA5VxOftPwMGojUaPGcZ//4xvV41nw/eEjfrEr6TiMO4iOTuEz3vMikgHlKGtpyhwmf4r5VARbICWUKmr5Vz1/iWOe3eRfvdA7C4V/dKdbAonncrGKkx2iKhLRXgrfK2Suntr27sw6OeYnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074394; c=relaxed/simple;
	bh=VvJypCpjkFueVE9+scbgJx9VGWbql+bdfUNA3/HmlDA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cgnIXWu431sucvqqJU0+kfFZIJVhPs7IVOMcDnGTCY92g2UfYtP67OjRi8tQ3lhu4bdBZfNSMBnD5vf6iv0yEkU+hCfVvZhJTBrZAg4KvPKi+Vvf+jWtNj/0gY1OZcja889K0AkgU0nTUktBAvz3vrFakKG9/Xmfpf9ZjN9e4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugWTmEP0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ci6ImHMQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JsX4Mc4eIerw5b7TnTBnTJGAAAPgL2Ki229NqdaNkHk=;
	b=ugWTmEP0UQXAuFxcuqCtXX9N7uGtVCMqnxWLcDUI1z85KBPdALdsy3f54MKOqWLvB31P9q
	ab82BWDsWG89cXETa+aFzBYTDlF7tfuoEPmCXeBGbFTKLKjLrURgKhVbf2wen0FEXICJgI
	8ClD07VBRWRpS9VPhEv0MrUcGoYZrhLepkGVQDusjH7Hzdlsl4xVZjohHcjWwGyG6t7lY9
	g6mpRjYD6vjaCM6Q3KuqjVirrG9e217UKkc84r7bCaQU1Wf2n8FGHCjay62uTpPRN2j9Cu
	i0AGox7Zy6vB8d8iHg+7w/BOy2oSnR5FyJYEQI6SPleDzt0uPPDXX+Wc3BvlBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JsX4Mc4eIerw5b7TnTBnTJGAAAPgL2Ki229NqdaNkHk=;
	b=Ci6ImHMQDvzbfno9YEi6Twt98WNsYQgpblFyPM3cljTPFlCTQu7MEeMy0q1GkYlpX4JSlj
	73xlmtIfEl23iuCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Clean up domain_remove_cpu_ctrl()
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437812.510.9221014618704007204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     c1b630573c8ca51a89bd480f7eeaf8754c7609f2
Gitweb:        https://git.kernel.org/tip/c1b630573c8ca51a89bd480f7eeaf8754c7=
609f2
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:51 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 04 Jan 2026 08:41:55 +01:00

x86/resctrl: Clean up domain_remove_cpu_ctrl()

For symmetry with domain_remove_cpu_mon() refactor domain_remove_cpu_ctrl()
to take an early return when removing a CPU does not empty the domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 49b133e..64ed81c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -604,28 +604,27 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_=
resource *r)
 		return;
 	}
=20
+	cpumask_clear_cpu(cpu, &hdr->cpu_mask);
+	if (!cpumask_empty(&hdr->cpu_mask))
+		return;
+
 	if (!domain_header_is_valid(hdr, RESCTRL_CTRL_DOMAIN, r->rid))
 		return;
=20
 	d =3D container_of(hdr, struct rdt_ctrl_domain, hdr);
 	hw_dom =3D resctrl_to_arch_ctrl_dom(d);
=20
-	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
-	if (cpumask_empty(&d->hdr.cpu_mask)) {
-		resctrl_offline_ctrl_domain(r, d);
-		list_del_rcu(&d->hdr.list);
-		synchronize_rcu();
-
-		/*
-		 * rdt_ctrl_domain "d" is going to be freed below, so clear
-		 * its pointer from pseudo_lock_region struct.
-		 */
-		if (d->plr)
-			d->plr->d =3D NULL;
-		ctrl_domain_free(hw_dom);
+	resctrl_offline_ctrl_domain(r, d);
+	list_del_rcu(&hdr->list);
+	synchronize_rcu();
=20
-		return;
-	}
+	/*
+	 * rdt_ctrl_domain "d" is going to be freed below, so clear
+	 * its pointer from pseudo_lock_region struct.
+	 */
+	if (d->plr)
+		d->plr->d =3D NULL;
+	ctrl_domain_free(hw_dom);
 }
=20
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)


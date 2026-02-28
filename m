Return-Path: <linux-tip-commits+bounces-8281-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH7ICx7Lomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8281-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:01:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51261C26B8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E90243000FFF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA26429810;
	Sat, 28 Feb 2026 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gzIPTbBy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256D2D879B;
	Sat, 28 Feb 2026 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276506; cv=none; b=e0RcfSzniNevh+hsxvQTataddhkc9O2Gxf+ZToyYWsQTI3uOF6s6/d77qsIkaJCYygtPQ30fDJon9GWdX3QKwe9BBXTbDzpbp3I2vrMbHEhHQcxBwbnfeoS+9BAOTe3awg2JBNtYktR178ra5/68jKit9VRgVJeUP3J1hT6D1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276506; c=relaxed/simple;
	bh=hAfYaM9r+IN4QSMQ+QY3SmL/SuHPy6+tywA2BUaWGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv2ORkuVnj5x85bTDDPp+ZdvaznWAwV7+yM2o83WvTL1mGe+DPKh9tqHZ6+GrHWWH7EOa0CC1cLsNCn0mp2xM1MmbyDehP8MtEr8dohUG3ElyxcGgGE1NYN4Tztuhy7dhjL2mhL4cgaBbkc8qOkupN4H/9XH7QQEQUGrkdp1vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gzIPTbBy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MlRET53VIb5MkY2u6TAoiJpwZYBMdm+7IBonjbEEiHE=; b=gzIPTbByreUIs4ASlDiAMioD5U
	hFHYKSO/eC5Kb/IoXYScBbW43vakQB/zGu1ju4FyxKsbGSccEcL0RrxEPtuz9uTo8xXan+Azt9efH
	srDkXd5ArdPq4I3kz78zdQDvOB+c/TT6ZwMl15U6q7/4J1rpPTJnW4IaIymJHzlkFViAINfus7ncf
	3d9FHXS4nfqeDZihWwmWbCk+20KENZcW0RmQlZ/d4tshDUg93Il+xx/qh0L6Upis/QZouRqbtuiik
	9z0ziTKiLzmZZcRwR0wzQyJYzZAVutnWX4JBfexhjiR7SVdedCrcHWQel1y5s23j9c7wOJEjeRyXo
	vVbVTtUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwI4s-0000000EWAK-2Wig;
	Sat, 28 Feb 2026 11:01:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 920AB3007C4; Sat, 28 Feb 2026 12:01:41 +0100 (CET)
Date: Sat, 28 Feb 2026 12:01:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org
Subject: Re: [tip: perf/core] to eliminate RMW race
Message-ID: <20260228110141.GM1282955@noisy.programming.kicks-ass.net>
References: <20260216042530.1546-4-ravi.bangoria@amd.com>
 <177227619773.1647592.3812702667944874434.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177227619773.1647592.3812702667944874434.tip-bot2@tip-bot2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8281-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-tip-commits@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,infradead.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: B51261C26B8
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:56:37AM -0000, tip-bot2 for Ravi Bangoria wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     28063f05f38b5c114b0c8d2b0200604196b085ef
> Gitweb:        https://git.kernel.org/tip/28063f05f38b5c114b0c8d2b0200604196b085ef
> Author:        Ravi Bangoria <ravi.bangoria@amd.com>
> AuthorDate:    Mon, 16 Feb 2026 04:25:26 
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 27 Feb 2026 16:40:24 +01:00
> 
> to eliminate RMW race

Argh, Subject got mangled and I failed to spot sooner :-(

Let me go rebase to fix.


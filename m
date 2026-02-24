Return-Path: <linux-tip-commits+bounces-8254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOEuNjecnWnwQgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 13:40:23 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB50187159
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 074E230BF429
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F33803DB;
	Tue, 24 Feb 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/y8xyW9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515537FF43;
	Tue, 24 Feb 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936734; cv=none; b=HDw027EEJHdokNJlmRtric8T1fdr87oaR8zNxhpiC0fmvZ/+uCn2DcdnUEdlIc9Y/6C82rBLOCb1Wt21Z+27j6E5HbdcUOvzJEsBe5B1jRSuW+o/B3Zi97WaaxtB7x4iPB8hJNWmORg6OcU88Kan/wPJUO2roFs1XwmYgSnZDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936734; c=relaxed/simple;
	bh=zYtJ6FEJHtaMFqUougXCjpN8qj7u1IZRgMrCpnDBgWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW1dR3OmundSNVCRcg34bWKyoal8rrUkfaaYJYGhf4XZ0bVJtMsWVA9FVu+Si9w1MciFEybJ8YSstOUDHg/myXZsodWNQ1ZPv2syFCeEhxiai5edJcDJsIefHzAGMF48E6qePsODml6Jo1WRC7fa4GYREXrnMz8khipwkHiJBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H/y8xyW9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tJCymVvVmy1xJBdKk5tpCzm5wzWBbNhUrhb1/4OOlI4=; b=H/y8xyW9PboeyOzjeyYwaDvAXU
	iyARXZZNiVvKfB3F7Jp3ZM932FnC9VfkYYV2/GLtCWiJd+xdlwx4OuNqQHiGR7GAiKjQ3T3x6nyce
	n0Tzhb2kyUvOy95ToV746J79vXIfAbDOqnnO/G8tDkEANYC7OiUMqDyILzDM93cVGhKIM0wZlIjda
	bC4+duiAIqXdhW9fCfTmiOO5WafhsSo6PQxHG8LwYrjECFpou2Kdm2mwwqXMSizBE3njQ1W+WpfHp
	3hmyixcyoPOUmSgnqpWaJCqU7cOJ3D7rn0C1yTaSWg3dv10MGKHqgO5w2Z/mahSwLpuxjbiIVvM2V
	Teernjqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vurgf-0000000Gpzu-0ngw;
	Tue, 24 Feb 2026 12:38:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D5A530095A; Tue, 24 Feb 2026 13:38:48 +0100 (CET)
Date: Tue, 24 Feb 2026 13:38:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf: Fix data race in
 perf_event_set_bpf_handler()
Message-ID: <20260224123848.GY1282955@noisy.programming.kicks-ass.net>
References: <20260224122909.GV1395416@noisy.programming.kicks-ass.net>
 <177193661171.1647592.9395163829843540847.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177193661171.1647592.9395163829843540847.tip-bot2@tip-bot2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8254-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-tip-commits@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 6AB50187159
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:36:51PM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the perf/urgent branch of tip:
> 
> Commit-ID:     5004d5c59874b18c8ecbcb507053750c8b47353c
> Gitweb:        https://git.kernel.org/tip/5004d5c59874b18c8ecbcb507053750c8b47353c
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 24 Feb 2026 13:29:09 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 24 Feb 2026 13:33:39 +01:00
> 

ARGH, let me go fix that :/


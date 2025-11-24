Return-Path: <linux-tip-commits+bounces-7523-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B99BCC82654
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 21:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B089A4E23B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA682EA168;
	Mon, 24 Nov 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CCplBg1J"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68182238C0D;
	Mon, 24 Nov 2025 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015303; cv=none; b=WItRyqau+0Z++OkKRJbDThhb21Un/zN3XFSW8/8xlzYJ8RiRHecJEhHa+k9gXzKs1MEdV2FyX+x0F1Sq0RVsQP4kI/YJbir6/OfsBLgMd7EfiwQBheiyof8Ead1T5W5ypeAfx8t7OvQIRoG+Q4rhoMq+YgkJiRHoxbv7Gsemd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015303; c=relaxed/simple;
	bh=H1Vfkzsnx2yoHxg8sT12hi7cDSm4CBQZ5KLE/BhfiVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmFc9W/300QXhgVXy7HMGqjPpahx+Db86rb7BMsXdfEAO8IwSVkNXSyPDLQ1HdBVjJb/1K/QyvfDptD06R5NdTouORnXjeyqVZwNdcHYj0OEmZWoUeM2Zj/2E2vGlNqyvpPikPrg9CrVrjh1Q6H+X3w3J7sHyCmKuBwlrMP4/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CCplBg1J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B7DD40E0217;
	Mon, 24 Nov 2025 20:14:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qdJ7Be_X16zl; Mon, 24 Nov 2025 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764015292; bh=8lkpzg1bJSw9zZO0edMgZN+voDVsTBG0rlfckgtRH9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCplBg1J3XyNIAeUDsb/eqKKEvSWEo2GFD722mWBQEqM30iZSg5oJDeJFs1Y1jYiT
	 AYMIsKk5CqhRVPEIYnOs/3w9sZa/mbsW4CicDmSCKPez89N4EOCOOBMJxvbDTG1boy
	 JfQd95wVLIoAxG7DkOvp/dkAUe6oxrITplFcUctreNA9EWAFCJURfEn09dnL1hjGzk
	 A9PQO2KsvuWwV4E8wjIIMZdlkjKl0836V1KsBHKWPEcBXTCJ+puzpLmwta/WIcVuZH
	 GNf/o5ziykLgWaZa63tltGCtKRrxPE/iRdl8MhD8fpKo6+mR4Y5uT938Qh11K9gN8T
	 Q94FBVubUeG6ZLAu0t+bWsb2skHzgb6SuKy6kQHXP0tIJWwIjwraCQcbbtzhrSflTx
	 pskDt7BQA0WXXyyyjfYAGoDoiSdfX55XHzcRJjj73sxFW6Os5c62Gz4aiIrmTOLTWy
	 YFIKtfpEehhwfiGhlzEGf3JQQ2Nn/QIdb4+GKAN638otkFFiYjH6e3M+E8kSRJY/D0
	 4kFFkzdWVXSeFTl8lr1R2VKCvPRp5qPVpvFeKXg0kPDfxUh8a85tXy+T5txIHb5eVB
	 At3Ad0deHvCRABysoY8Z4hm/yILMbg0c6KbviZe92L5VOZFHFEv/+9NUQLOvir7IMM
	 +pXUD0OsaYg9mwFZTTinsPDs=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A01C740E015B;
	Mon, 24 Nov 2025 20:14:46 +0000 (UTC)
Date: Mon, 24 Nov 2025 21:14:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Function to get the name of a CPU
 feature
Message-ID: <20251124201440.GJaSS8sAXasG6FV-g1@fat_crate.local>
References: <20251121095340.464045-27-alexandre.chartre@oracle.com>
 <176398104154.498.14035591969424868341.tip-bot2@tip-bot2>
 <20251124115942.GO4067720@noisy.programming.kicks-ass.net>
 <20251124122639.GBaSRO_-G9dUtVHMaY@fat_crate.local>
 <cf0ecf1e-6d7c-4d5e-8f8a-27446b801c94@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf0ecf1e-6d7c-4d5e-8f8a-27446b801c94@oracle.com>

On Mon, Nov 24, 2025 at 05:43:04PM +0100, Alexandre Chartre wrote:
> Here is a fix. It works with gawk and mawk:

Yap, works, thanks!

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-tip-commits+bounces-5220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0EAA8598
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8522A176319
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ADE19F47E;
	Sun,  4 May 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hn0T5Py7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98A19DF48;
	Sun,  4 May 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352346; cv=none; b=IZ+p6ucU03e2m7leQE2MZI4ktMSaU8gTRX9iPJV4iEGNuJj+M+n/26xq/DdC25wTyGsMS1arpSu+VgewwNq6ac8sbVSfxhkaU3s9kbnmGoAu0bn9b5YIX4plqdA6JOWsC7QJ3qdnrQo6+egP1LXOjTZGNYyLJPbdw7AoTNhnpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352346; c=relaxed/simple;
	bh=Nze/SA9bYUHiBqOk4wcv/+05FhwIreXwokqHCkJ0EB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua5vMoqZIksnRIvkmiQ3V/ItHf9eBgRklOS36i0BPr2HlZHM6aEgHdcrCxbLZI71zuxqgYDhnCOgxMmwGq7fGVGDFex79wY/pvxh001aGSXIXM4VpiwWOMaDmT7IytiuLjP73lSbgJG0AR7uP0FiYlGBM4I+Amuk8lH93/fD644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hn0T5Py7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5BA340E0173;
	Sun,  4 May 2025 09:52:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZtFx5EtG6rfo; Sun,  4 May 2025 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746352338; bh=Cm20TX7ygDvmsM4levbHO9jiUOJ71+S+/h1MXQi3RaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hn0T5Py7vS32ScDM8L1WzrM1qKSM1yXd2cIKLZBIa69wALuKjNEQks57yCAmUinkE
	 2hk9TQaMRGlkPgC8Ie9cXdTgp2AWmISB/LPX3T5xSdlWd53byAgSYfVRwpovgDWlR1
	 LMW0Cg/qvnT3O4aBilu9N3XbzhAoGFDrl9vaN1xZYOi7Ee1GgkLgoHt6NluJ6e6eQ+
	 Z1S2yjWI7j4NC32YrDdJzidJfLbkP9e+7VU9DkxOFbakCBklLFiOPPJyN4+m3P+lfO
	 a54FqQ47DG4cr0E8pLgJn+oWVDKW2QV3QJ2OSTINmIJI+D1bUpbPYwgf482ViMf1eK
	 n7mPXoO9gp/++4iEsnlMuRqC1tGlVKSE43mOZW7bBZ6s0PVXnK5yIgWuoMiW+jNBRK
	 MXbTcgdSy+GSVDPyo9yMHz0gFhLmizowctXVLlaGns3meoezMfVQt8jKHW53rAIXne
	 mEsTu16azrChJUwHhodzyV1Wt60svgFhrbWl4w04qsyPs5a4DR2MkJNtIrEuEU+Tyn
	 p8D55sBFkH5efaZL3deh8ZeIT/5l1IthZw+OQ1K7T/Ww0y2qgIxGB/cOmGACuM5XHH
	 itYgV2wI1tnggTeX/VzD7l9v+UWEEETszga7kioFVRM+F3C0WUybSVCI6ZxmMORsmZ
	 EF8yWov39jcKtPBO084jdwyA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A24A40E0196;
	Sun,  4 May 2025 09:52:12 +0000 (UTC)
Date: Sun, 4 May 2025 11:52:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: Clean up the last-reset printing code a bit
Message-ID: <20250504095212.GBaBc4zOxcAKQ26cbn@fat_crate.local>
References: <20250422234830.2840784-6-superm1@kernel.org>
 <174617858494.22196.5727323411231361285.tip-bot2@tip-bot2>
 <aBcLJxjTQGa1-r5S@gmail.com>
 <aBcRXYkJlfySzBEx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBcRXYkJlfySzBEx@gmail.com>

On Sun, May 04, 2025 at 09:03:57AM +0200, Ingo Molnar wrote:
> Patch attached to clean this all up.

Ack, just merge it into Mario's original patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


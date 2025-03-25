Return-Path: <linux-tip-commits+bounces-4535-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D829A701E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 14:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB633189CEC8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC61B25D91E;
	Tue, 25 Mar 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8Op20jJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6A25D52E;
	Tue, 25 Mar 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908335; cv=none; b=as8/YoekosFp9jq2vNN5ppUYTQBS4LilB+QO4Qwd4zIoETW0KWhJJBE2ARZqNBOmNyJtJKkVZVzjWDLcJk0qnsjQkzjPt5InOa3l57QTVuNZT+HHW4nmri0AAdYK99RLjQ4W3Yic43CrMrq/z0Qqt+PkQ6sW8NeagHxx6lS2jHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908335; c=relaxed/simple;
	bh=4aswzqAW+ogeV4aHAXwjgfEpwAH3OmO8RxKMs9jtGYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/x/LaJVCMVjvjXeDJT3Vg4OeLT4dspdrikRE0/GpSVbiCx+a6RrtZ6+NIAM90YTjuRbjbTBdOHI7gQgTw+BMg38oJTe6cdS2SbEeLI1wtqqROgl7h8vMESKKWbLmj1PdB3lpWeEPZ7kN5SWFhcpew3c0h8D0HWbVRmhTnVNaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8Op20jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907DBC4CEE4;
	Tue, 25 Mar 2025 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908334;
	bh=4aswzqAW+ogeV4aHAXwjgfEpwAH3OmO8RxKMs9jtGYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8Op20jJ/0e8QXGJc7jpQYgFvB4iN6yNNFI/7hbkRjvr4GJ6EYwOTnPfC1byBl2Gl
	 O/y9mBE+ow771lKXKQ42evwjcN/kdOzIZc6wXEZ2LD8iwG6Ru9Is/c6dL5xwBYZdnX
	 Ue/BC0KjvNYq4LafjaEnkeCtVe0LN0EZKAIxExdYMtQr4oAuTrG6W91V/4I2+2uuTg
	 0Rp/UEc/ijVbAgkXp07jlMpJpjSxwatqWgdSlqnry2W5eg1dO3eAeQPb3yWaZAfpR1
	 kyo4VzPVfLfDt/Fil2JuG8lq5HZ8/9ufRuh7+0wcPqehT/MjmCXliQNXsqh1R28157
	 JCiQoe2qsp9OA==
Date: Tue, 25 Mar 2025 13:12:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, ASoC: codecs: wcd934x: Remove
 potential undefined behavior in wcd934x_slim_irq_handler()
Message-ID: <331c7461-9adc-4bd4-b164-b4d8738517b9@sirena.org.uk>
References: <7e863839ec7301bf9c0f429a03873d44e484c31c.1742852847.git.jpoimboe@kernel.org>
 <174289169388.14745.12400458342392826127.tip-bot2@tip-bot2>
 <0b3b6878-a1c1-4cd0-b2a8-d70833759578@sirena.org.uk>
 <Z-KVKztS2TXoafRC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfSLrB3N/gT31HVe"
Content-Disposition: inline
In-Reply-To: <Z-KVKztS2TXoafRC@gmail.com>
X-Cookie: Visit beautiful Vergas, Minnesota.


--yfSLrB3N/gT31HVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:36:11PM +0100, Ingo Molnar wrote:

> > FWIW the original patch doesn't seem to have made it into my inbox=20
> > (the regmap one did), not that it makes a *huge* difference but might=
=20
> > be some infra/script issue which crops up on some other more urgent=20
> > occasion.

> Yeah, I noticed that the Cc: lines were incomplete for some of the=20
> patches, so before applying them I went over the series and regenerated=
=20
> the Cc: lines so everyone is informed and can review/object/ack if=20
> necessary.

> If there's any serious mistake we'll rebase the branch!

No problem here, just wanted to flag the potential infra thing.  I
didn't bother acking since the patches were applied:

Acked-by: Mark Brown <broonie@kernel.org>

--yfSLrB3N/gT31HVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfiq6cACgkQJNaLcl1U
h9AMjQf/RFqT8qnAq1etw/12Io1sEmxD+ZCkkItji7YORoarHu9h4KZEHSMfDY8k
3GhncE7q+QglCdZ7+OB7DRhOi49Ts4+9orRs/Ezcf3XPtjmq4tRmaCViSmfZO42/
Lqd6nBIx/2Ktt0Oh2el9xuVNk+371GiollzcNSB0sZcL/a84RwIiRG9EKJlMufet
5OcBxuD5nI2lpoCg9DgAtzsBJiHfj5+QLWybRC4dF1YUupz8nPdbnsFhj0xXp4ob
NBIwQ+keCrhrGgv3KqsWnngwTQLu6EpZWzT9I/7yh+7a+G4a1u5kdYmEyj1oQL4C
Q/bEyHscWDC4ivyDRTJ/nP1i7UssvA==
=siZn
-----END PGP SIGNATURE-----

--yfSLrB3N/gT31HVe--

